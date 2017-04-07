require('capybara/rspec')
    require('./app')
    Capybara.app = Sinatra::Application
    set(:show_exceptions, false)

    describe('Create a new stylist', {:type => :feature}) do
      it('will find the form and create a new stylist then go to the stylists lists') do
        visit('/')
        visit('/admin')
        visit('/stylists/new')
        fill_in('name', :with =>'Sheeja')
        click_button('Add Stylist')
        expect(page).to have_content('Success!')
        visit('/stylists')
        expect(page).to have_content('Sheeja')
      end
    end
