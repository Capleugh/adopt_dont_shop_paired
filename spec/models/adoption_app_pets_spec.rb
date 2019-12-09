require 'rails_helper'

RSpec.describe AdoptionAppPet do 
  describe "relationships" do 
    it {should belong_to :adoption_app}
    it {should belong_to :pet}
  end 

end 
