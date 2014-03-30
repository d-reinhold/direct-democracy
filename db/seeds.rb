dom = Citizen.create!(name: 'Dominick Reinhold')
kirill = Citizen.create!(name: 'Kirill Kireyev')
greg = Rep.create!(name: 'Greg Coladonto')

greg.citizens << dom
greg.citizens << kirill

social_justice = Tag.create!(name: 'social justice')
environment = Tag.create!(name: 'the environment')
public_health = Tag.create!(name: 'public health')
computers = Tag.create!(name: 'computers')
Tag.create!(name: 'education')
Tag.create!(name: 'agriculture')
Tag.create!(name: 'the economy')
Tag.create!(name: 'small businesses')
Tag.create!(name: 'foreign relations')

dom.tags.push environment
dom.tags.push computers

kirill.tags.push social_justice
kirill.tags.push public_health
kirill.tags.push computers

bill1 = Bill.create!(
  name: 'AB 1649 - Computer Crimes',
  link: 'http://leginfo.ca.gov/pub/13-14/bill/asm/ab_1601-1650/ab_1649_bill_20140211_introduced.htm',
  summary: 'This bill would double the fine for both felony and misdemeanor computer crimes, and modernizes the language used in current laws.'
)

bill2 = Bill.create!(
    name: 'AB 2115 - Cal Fresh',
    link: 'http://leginfo.ca.gov/pub/13-14/bill/asm/ab_2101-2150/ab_2115_bill_20140220_introduced.htm',
    summary: 'This bill would require country welfare departments to compile lists of available feeding programs for children, and make these programs known to CalFresh applicants.'
)

bill3 = Bill.create!(
    name: 'AB 976 - Coastal Resources',
    link: 'http://leginfo.ca.gov/cgi-bin/postquery?bill_number=scr_92&sess=CUR&house=B',
    summary: 'This bill would update the California Coastal Act of 1976 to impose harsher consequences on developers who fail to obtain a necessary coastal development permits.'
)

bill1.tags << computers
bill2.tags << social_justice
bill2.tags << public_health
bill3.tags << environment
