module ApplicationHelper
    def quote_source_url(quote)
        case quote.source_type
        when "Person"
            person_url(quote.source)
        when "Book"
            book_url(quote.source)
        when "Movie"
            movie_url(quote.source)
        when "TvShow"
            tv_show_url(quote.source)
        else
            "http://www.loveaquote.com"
        end
    end

    def admin_quote_source_url(quote)
        case quote.source_type
        when "Person"
            admin_person_url(quote.source)
        when "Book"
            admin_book_url(quote.source)
        when "Movie"
            movie_url(quote.source)
        when "TvShow"
            tv_show_url(quote.source)
        else
            "http://www.loveaquote.com/admin"
        end
    end

    def model_url(model, options={})
        eval("#{model.model_name.param_key}_url(model, options)")
    end

    def page_model_url(model, page, options={})
        eval("page_#{model.model_name.param_key}_url(model, page, options)")
    end

    def admin_model_url(model)
        eval("admin_#{model.model_name.param_key}_url(model)")
    end

    def review_admin_model_url(model)
        eval("review_admin_#{model.model_name.param_key}_url(model)")
    end

    def edit_model_url(model)
        eval("edit_#{model.model_name.param_key}_url(model)")
    end

    def edit_admin_model_url(model)
        eval("edit_admin_#{model.model_name.param_key}_url(model)")
    end

    def canonical_url(model, *page, options)
        if page.present?
            page_model_url(model, page, options)
        else
            model_url(model, options)
        end
    end
end