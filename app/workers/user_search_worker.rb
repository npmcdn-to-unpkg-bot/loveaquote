class UserSearchWorker
    include Sidekiq::Worker
    
    def perform(class_name, id, search)
        source = class_name.constantize.find(id)
        UserSearch.create(source: source, text: search) if source
    end
end