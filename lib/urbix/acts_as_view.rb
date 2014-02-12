# urbix/lib/urbix/acts_as_view.rb
module Urbix
  module ActsAsView
    extend ActiveSupport::Concern
    included do
    end
    
    class ViewRelations
      attr_reader :needed_relations, :klass
      
      def initialize(model_klass)
        @klass = model_klass
        @selects = []
        # hash which associate tables to an array of belongs_to relation chain
        # for each belongs_to relations chain this class will genereate a table reference 
        # in from_clause and a join condition in join_clause
        @needed_relations = {}
        # hash wich associate a belongs_to chain to a table_reference
        @table_ref = {}
      end

      def add(name, belongs_to_list)
        belongs_list = belongs_to_list.dup
        # 1. retrieve column name that is the last element from belongs_rel_list
        col_name = belongs_list.pop
        # 2. get table reference for the complete belongs_to relation chain
        # this action will also add the corresponding relation if needed
        table_ref = ref_bl_list(belongs_list)
        # 3. Build select clause for this relation
        @selects << "#{table_ref}.#{col_name} as #{name}"
        # 4. add all relations required by the belongs_to list
        until belongs_list.empty?
          ref_bl_list(belongs_list) 
          belongs_list.pop
        end

      end
      
      def join_clause
        clause = []
        @needed_relations.each do |ref_table,rel_list|
          rel_list.each do |relation|
             reflection = relation.last
             fk = reflection.foreign_key
             pk = reflection.klass.primary_key
             bl_list = relation[0...-1] + [reflection.name]
             ref_table = @table_ref[relation[0...-1]] || klass.table_name
             bel_table = @table_ref[bl_list]
             clause << "#{ref_table}.#{fk}=#{bel_table}.#{pk}"
          end
        end
        clause.join(" and ")
      end
      
      def from_clause
        clause = [klass.table_name]
        @needed_relations.each do |ref_table,v|
          clause << ref_table
          i = 1
          v[1..-1].each{ |bl| clause << "#{ref_table} #{ref_table}_#{i}" ; i+=1 }
        end
        clause.join(', ')
      end
      
      def select_clause
        @selects.join(', ')
      end
      
      private
      
      def add_relation(reflection, belongs_list)
        @needed_relations[reflection.table_name] ||= []
        relation = belongs_list + [reflection]
        index = @needed_relations[reflection.table_name].index(relation)
        if index.nil?
          @needed_relations[reflection.table_name] << relation
          index = @needed_relations[reflection.table_name].size - 1
          t_ref = reflection.table_name 
          t_ref += "_#{index}" if index > 0
          @table_ref[belongs_list + [reflection.name]]  = t_ref
        end
        return @table_ref[belongs_list + [reflection.name]]
      end
      
      # reference the belongs to list and return the referenced table for this chaining relation
      def ref_bl_list(belongs_list)
        ref_klass = klass
        belongs_list[0...-1].each{|bl_rel|
          if ref_klass.reflections[bl_rel].nil?
            Logger.error "Failed to acts_as_view on class for #{name} attributes : 
            Undefined belongs_to relation #{bl_rel} on #{ref_klass}"
          else
            ref_klass = ref_klass.reflections[bl_rel].klass
          end
        }
        add_relation(ref_klass.reflections[belongs_list.last],belongs_list[0...-1])
      end
      
    end
    
    module ClassMethods
      
      def acts_as_view(options = {})
        # 1. call block to customise views attributes
        vr = ViewRelations.new(self)
        yield vr if block_given?
        puts "#{self}"
        self.class_variable_set(:@@_View__Relations,vr)
        class_eval do
          def self.view
            # View method return ActiveRecord Relation to retrieve view element in one request
            vr = self.class_variable_get(:@@_View__Relations)
            select_columns = Mail.columns_hash.keys.collect{|col| "#{self.table_name}.#{col}"}
            select_columns << vr.select_clause unless vr.select_clause.empty?
            select(select_columns.join(', ')).from(vr.from_clause).where(vr.join_clause)
          end
        end
      end
    end
  end
end
 
ActiveRecord::Base.send :include, Urbix::ActsAsView

