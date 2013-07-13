namespace :irb do
  task :puts => :environment do

    puts "========attributes========================================================"
    puts Moneyplan::Application.config.attributes.inspect
    puts "=========================================================================="

  end

  task :brsave => :environment do

    aa = Forms::BreakdownFront.new()
    aa.name = "aaaaaaaa"
    aa.price = "bbbbbbbbbb"
puts aa.to_xml

    aa.save

  end



  task :bfind => :environment do

#    aa = Forms::BreakdownFront.find("20130307154505808")
    aa = Forms::BreakdownFront.find("20130314095330520")
#    aa = Breakdown.first  => nil  # => nil が返る
p aa
  end



  task :brall => :environment do

    aa = Forms::BreakdownFront.all
    p "-----------------------------------------------------------"
    p aa

    p "------ size -----------------------------------------------------"
    p aa.size


  end







  task :ba => :environment do

    aa = BreakdownFront.new
    aa.





    p "-----------------------------------------------------------"
    p aa

    p "------ size -----------------------------------------------------"
    p aa.size


  end






end
