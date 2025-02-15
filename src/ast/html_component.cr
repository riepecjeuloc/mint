module Mint
  class Ast
    class HtmlComponent < Node
      getter attributes, children, component, comments, ref

      def initialize(@attributes : Array(HtmlAttribute),
                     @comments : Array(Comment),
                     @children : Array(Node),
                     @ref : Variable?,
                     @component : TypeId,
                     @input : Data,
                     @from : Int32,
                     @to : Int32)
      end

      def static?
        children.all?(&.static?) && ref.nil? && attributes.all?(&.static?)
      end

      def static_value
        static_hash
      end

      def static_hash
        component.value +
          attributes.join(&.static_value) +
          children.join(&.static_value)
      end
    end
  end
end
