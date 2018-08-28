module Pageable
  extend ActiveSupport::Concern

  included do
    scope :paged, ->(params) do
      page_sz = params[:page_size].to_i
      page_sz = model.per_page if page_sz <= 0 || page_sz > model.max_page_sz

      page_num = params[:page_number].to_i
      page_num = 1 if page_num <= 0

      limit(page_sz).offset((page_num - 1) * page_sz).extending(PagedScope)
    end
  end

  class_methods do
    def per_page
      10
    end

    def max_page_sz
      25
    end
  end

  module PagedScope
    def page_number
      (@values[:offset] / @values[:limit]) + 1
    end

    def pages_count
      @pages_count ||= calculate_total_pages_count
    end

    def next_page?
      page_number != pages_count
    end

    def previous_page?
      page_number > 1
    end

    def next_page_number
      page_number + 1 if next_page?
    end

    def previous_page_number
      page_number - 1 if previous_page?
    end

    # Override spawn to clear instance variable caches
    def spawn #:nodoc:
      remove_instance_variable :@pages_count if instance_variable_defined? :@pages_count

      super
    end

    private

    def calculate_total_pages_count
      pages_count = limit(nil).offset(nil).count
      pages_count /= @values[:limit]
      pages_count < 1 ? 1 : pages_count
    end
  end
end
