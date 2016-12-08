if defined?(SeedHelper)
  SeedHelper.create_seed_task(:clients) do
    FactoryGirl.create_list(:client, 5)
  end
end
