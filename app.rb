require "sinatra"
require "sinatra/activerecord"
require_relative "./lib/kickstarter.rb"

class Application < Sinatra::Base
    enable :sessions

    before do
        if session[:user].nil? && request.path != "/users"
            unless params["name"]
                redirect "/users"
            end
        end
    end

    get /\/|\/projects/ do
        erb :index, layout: :layout, locals: {projects: Project.all}
    end

    get "/projects/new" do
        erb :create, layout: :layout
    end

    get "/users" do
        erb :user, layout: :layout
    end

    get "/projects/:id" do |id|
        erb :project, layout: :layout, locals: {project: Project.find(id)}
    end 

    post "/users" do
        session[:user] = User.create(params)

        redirect "/projects"
    end

    post "/projects" do
        Project.create(params)
        erb :index, layout: :layout, locals: {projects: Project.all}
    end

    get "/projects/:id/delete" do |id|
        Project.delete(id)
        erb :index, locals: {projects: Project.all}, layout: :layout
    end

    get "/projects/:id/edit" do |id|
        erb :edit, locals: {project: Project.find(id)}, layout: :layout
    end

    post "/projects/:id/update" do |id|
        project = Project.find(id)
        project.update(params)

        erb :index, layout: :layout, locals: {projects: Project.all}
    end

    post "/projects/:id/pledge" do |id|
        project = Project.find(id)
        project.pledges.create(amount: params["amount"], user_id: session[:user].id)
        redirect "/projects/#{id}"
    end
end
