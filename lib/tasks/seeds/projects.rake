if defined?(SeedHelper)
  SeedHelper.create_seed_task(:projects) do

    FactoryGirl.create(:client, name: "Bananas and Sons")
    FactoryGirl.create_list(:project, 3, client: Client.last)
  end
end
