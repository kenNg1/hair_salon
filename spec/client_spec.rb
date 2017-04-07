require("rspec")
require("pg")
require("client")

DB = PG.connect({:dbname => 'hair_salon_test'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM clients *;")
  end
end

describe(Client) do

  describe(".all") do
    it("is empty at first") do
      expect(Client.all()).to(eq([]))
    end
  end

  describe("#save") do
    it("adds a client to the array of saved clients") do
      test_client = Client.new({:name => "Iana", :stylist_id => 1, :id => nil})
      test_client.save()
      expect(Client.all()).to(eq([test_client]))
    end
  end

describe("#==") do
  it("is the same task if it has the same description and list ID") do
    test_client = Client.new({:id => nil, :name => "Iana", :stylist_id => 1})
    test_client2 = Client.new({:id => nil, :name => "Iana", :stylist_id => 1})
    expect(test_client).to(eq(test_client2))
  end
end


describe(".find") do
    it("returns a client by its ID") do
      test_client1 = Client.new({:id => nil, :name => "Iana", :stylist_id => 1})
      test_client1.save()
      test_client2 = Client.new({:id => nil, :name => "Gordonita", :stylist_id => 1})
      test_client2.save()
      expect(Client.find(test_client1.id())).to(eq(test_client1))
    end
  end

describe("#update") do
  it("lets you update stylists in the database") do
    client = Client.new({:id => nil, :name => "Iana", :stylist_id => 1})
    client.save()
    client.update({:name=>"Ianette",:stylist_id => 2})
    expect(client.name()).to(eq("Ianette"))
  end
end

describe("#delete") do
  it("lets you delete a client from the database") do
    client = Client.new({:id => nil, :name => "Iana", :stylist_id => 1})
    client.save()
    client2 = Client.new({:id => nil, :name => "Gordonita", :stylist_id => 1})
    client2.save()
    client.delete()
    expect(Client.all()).to(eq([client2]))
  end
end

end
