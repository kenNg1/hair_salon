require('rspec')
require('pg')
require('stylist')

DB = PG.connect({:dbname => 'hair_salon_test'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM stylists *;")
  end
end

describe(Stylist) do
  describe(".all") do
    it("starts off with no stylists") do
      expect(Stylist.all()).to(eq([]))
    end
  end

  describe("#name") do
    it("tells you their name") do
      stylist = Stylist.new({:name => "Gordonita", :id => nil})
      expect(stylist.name()).to(eq("Gordonita"))
    end
  end

  describe("#save") do
    it("lets you save stylists to the database") do
      stylist = Stylist.new({:name => "Gordonita", :id => nil})
      stylist.save()
      expect(Stylist.all()).to(eq([stylist]))
    end
  end

  describe("#id") do
    it("sets its ID when you save a stylist") do
      stylist = Stylist.new({:name => "Gordonita", :id => nil})
      stylist.save()
      expect(stylist.id()).to(be_an_instance_of(Fixnum))
    end
  end

  describe("#==") do
    it("is the same stylist if it has the same name") do
      stylist = Stylist.new({:name => "Gordonita", :id => nil})
      stylist2 = Stylist.new({:name => "Gordonita", :id => nil})
      expect(stylist).to(eq(stylist2))
    end
  end
end

describe(".find") do
    it("returns a stylist by its ID") do
      stylist = Stylist.new({:name => "Gordonita", :id => nil})
      stylist.save()
      stylist2 = Stylist.new({:name => "Lavienne", :id => nil})
      stylist2.save()
      expect(Stylist.find(stylist2.id())).to(eq(stylist2))
    end
  end

describe("#tasks") do
  it("returns an array of clients for that stylist") do
    stylist = Stylist.new({:name => "Gordonita", :id => nil})
    stylist.save()
    client = Client.new({:id => nil, :name => "Lavienne", :stylist_id => stylist.id()})
    client.save()
    client2 = Client.new({:id => nil, :name => "Iana", :stylist_id => stylist.id()})
    client2.save()
    expect(stylist.clients()).to(eq([client,client2]))
  end
end

describe("#update") do
  it("lets you update stylists in the database") do
    stylist = Stylist.new({:name => "Gordonita", :id => nil})
    stylist.save()
    stylist.update({:name=>"Gordon"})
    expect(stylist.name()).to(eq("Gordon"))
  end
end

describe("#delete") do
  it("lets you delete a stylist from the database") do
    stylist = Stylist.new({:name => "Gordonita", :id => nil})
    stylist.save()
    stylist2 = Stylist.new({:name => "Iana", :id => nil})
    stylist2.save()
    stylist.delete()
    expect(Stylist.all()).to(eq([stylist2]))
  end
  
end
