# urbix/lib/urbix/acts_as_view.rb
module Urbix
  module ActsAsView
    extend ActiveSupport::Concern
 
    included do
    end
    class ViewRelations
      attr_reader :relations
      Struct.new("Relation", :table, :table_ref, :rel_table, :rel_table_ref)
      
      def initialize
        @selects = []
        @tables = {}
      end
      
      def add_relation(reflection, belongs_list)
        @tables[reflection.table_name] ||= []
        if @tables[reflection.table_name].index(belongs_list).nil?
          @tables[reflection.table_name] << belongs_list
        end
        return "#{reflection.table_name}_#{@tables[reflection.table_name].index(belongs_list).to_s}"
      end

      def add_reflection(name, pbelongs_list)
        belongs_list = pbelongs_list.dup
        # 1. retrieve column name that is the last element from belongs_rel_list
        col_name = belongs_list.pop
        table_ref = nil
        until (belong_rel = belongs_list.pop).nil?
          ref_klass = klass
          belongs_list.each{|bl_rel|
            ref_klass = ref_klass[bl_rel].klass
          }
          table_ref ||= add_relation(ref_klass[belong_rel],belongs_list)
        end
        # Build select clause for this relation
        @selects << "#{table_ref}.#{col_name} as #{name}"

      end
      
      def join_clause
        # TODO
        #klass.reflections[:belong_rel].klass.primary_key
        #klass.reflections[:belong_rel].foreign_key
        #klass.reflections[:bleong_rel].table_name        
      end
      
      def form_clause
        # TODO
      end
      
      def select_clause
        @selects.join(', ')
      end
    end
    
    module ClassMethods
      
      def add_view_column(attribute, belong_chain)
        @_view__columns ||= {}
        # TODO check attribute is not an existing attribute and belong_chain is valid
        @_view__columns[attribute] = belong_chain
      end
      
      def acts_as_view(options = {})
        # 1. call block to customise views attributes
        yield
        # 2. View method return ActiveRecord Relation to retrieve view element in one request
        self.class_eval do
          def self.view
            
            # for each attribute build 
            self.attributes + reflections.keys
          end
        end
      end
    end
  end
end
 
ActiveRecord::Base.send :include, Urbix::ActsAsView

