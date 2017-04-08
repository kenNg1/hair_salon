require('sinatra')
    require('sinatra/reloader')
    require('./lib/client')
    require('./lib/stylist')
    also_reload('lib/**/*.rb')
    require("pg")

    DB = PG.connect({:dbname => "hair_salon"})

    get("/") do
      erb(:index)
    end

    get("/admin") do
      @stylists = Stylist.all()
      @clients = Client.all()
      erb(:admin)
    end

     get('/stylists') do
      @stylists = Stylist.all()
      erb(:stylists)
    end

    get('/stylists/new') do
     erb(:stylists_new)
   end

      post("/stylists") do
        name = params.fetch("name")
        stylist = Stylist.new({:name => name, :id => nil})
        stylist.save()
        erb(:stylist_success)
       end

   get('/clients') do
     @clients = Client.all()
    erb(:clients)
  end

  get('/clients/new') do
   erb(:clients_new)
  end

    post("/clients") do
      name = params.fetch("name")
      stylist_id = params.fetch("stylist_id")
      client = Client.new({:name => name,:stylist_id => stylist_id, :id => nil})
      client.save()
      erb(:client_success)
     end

    get("/stylist/:id") do
    @stylist = Stylist.find(params.fetch("id").to_i())
    erb(:stylist)
    end

      delete("/stylists") do
        stylist = Stylist.find(params.fetch("id").to_i)
        stylist.delete()
        erb(:stylist_success)
       end


    delete("/clients") do
      client = Client.find(params.fetch("id").to_i)
      client.delete()
      erb(:client_success)
     end

     get("/stylists/:id/edit") do
       @stylist = Stylist.find(params.fetch("id").to_i())
       erb(:stylist_edit)
     end

         patch("/stylists/:id") do
           name = params.fetch("name")
           @stylist = Stylist.find(params.fetch("id").to_i())
           @stylist.update({:name => name})
           erb(:stylist_success)
         end

     get("/client/:id/edit") do
       @client = Client.find(params.fetch("id").to_i())
       erb(:client_edit)
     end

         patch("/clients/:id") do
           name = params.fetch("name")
           stylist_id = params.fetch("stylist_id")
           @client = Client.find(params.fetch("id").to_i())
           @client.update({:name => name, :stylist_id => stylist_id})
           erb(:client_success)
         end
