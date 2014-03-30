dom = Citizen.create!(name: 'Dominick Reinhold')
u1 = Citizen.create!(name: Faker::Name.name)
u2 = Citizen.create!(name: Faker::Name.name)
u3 = Citizen.create!(name: Faker::Name.name)
u4 = Citizen.create!(name: Faker::Name.name)
u5 = Citizen.create!(name: Faker::Name.name)
u6 = Citizen.create!(name: Faker::Name.name)
u7 = Citizen.create!(name: Faker::Name.name)
u8 = Citizen.create!(name: Faker::Name.name)
kirill = Citizen.create!(name: 'Kirill Kireyev')
greg = Rep.create!(name: 'Greg Coladonto')

greg.citizens << dom
greg.citizens << kirill

social_justice = Tag.create!(name: 'social justice')
environment = Tag.create!(name: 'the environment')
public_health = Tag.create!(name: 'public health')
computers = Tag.create!(name: 'computers')
education = Tag.create!(name: 'education')
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
  summary: 'This bill would double the fine for both felony and misdemeanor computer crimes, and updates the law with modern language.'
)

bill2 = Bill.create!(
    name: 'AB 2115 - Cal Fresh',
    link: 'http://leginfo.ca.gov/pub/13-14/bill/asm/ab_2101-2150/ab_2115_bill_20140220_introduced.htm',
    summary: 'This bill would require country welfare departments to compile lists of available feeding programs for children, as well as make those programs known to CalFresh applicants.'
)

bill3 = Bill.create!(
    name: 'AB 976 - Coastal Resources',
    link: 'http://leginfo.ca.gov/pub/13-14/bill/sen/sb_0051-0100/scr_92_bill_20140226_introduced.htm',
    summary: 'This bill would update the California Coastal Act of 1976 to impose harsher consequences on developers who fail to obtain a necessary coastal development permits.'
)

bill4 = Bill.create!(
    name: 'AB 148 - Salton Sea Restoration',
    link: 'http://leginfo.ca.gov/pub/13-14/bill/asm/ab_0101-0150/ab_148_bill_20140324_amended_sen_v97.htm',
    summary: 'This bill would help speed up the restoration of the Salton Sea by eliminating the requirement that the secretary and the Legislature have final approval for any proposed restoration plan.',
    passed: true,
    result: '78 - 0'
)

bill5 = Bill.create!(
    name: 'AB 255 - Digital Arts Degree Pilot Program',
    link: 'http://leginfo.ca.gov/pub/13-14/bill/asm/ab_0251-0300/ab_255_bill_20130319_amended_asm_v98.htm',
    summary: 'This bill would establish a Digital Arts Degree Pilot Program at the California Community Colleges and up to 8 campuses of the California State University.',
    passed: false,
    result: '23 - 55'
)

bill6 = Bill.create!(
    name: 'AB 37 - Environmental Quality',
    link: 'http://leginfo.ca.gov/pub/13-14/bill/asm/ab_0001-0050/ab_37_bill_20121203_introduced.htm',
    summary: 'This bill would improve record keeping requirements for local lead agencies, and would require the state to reimburse local agencies for additional costs.',
    passed: true,
    result: '78 - 0'
)



bill1.tags << computers
bill2.tags << social_justice
bill2.tags << public_health
bill3.tags << environment
bill4.tags << environment
bill5.tags << computers
bill5.tags << education
bill6.tags << environment
bill6.tags << public_health

Vote.create!(citizen_id: u1.id, bill_id: bill1.id, value: true)
Vote.create!(citizen_id: u2.id, bill_id: bill1.id, value: false)
Vote.create!(citizen_id: u3.id, bill_id: bill1.id, value: true)
Vote.create!(citizen_id: u4.id, bill_id: bill1.id, value: true)
Vote.create!(citizen_id: u5.id, bill_id: bill1.id, value: true)
Vote.create!(citizen_id: u6.id, bill_id: bill1.id, value: false)
Vote.create!(citizen_id: u7.id, bill_id: bill1.id, value: true)
Vote.create!(citizen_id: u8.id, bill_id: bill1.id, value: true)
Vote.create!(citizen_id: u1.id, bill_id: bill2.id, value: true)
Vote.create!(citizen_id: u2.id, bill_id: bill2.id, value: true)
Vote.create!(citizen_id: u3.id, bill_id: bill2.id, value: false)
Vote.create!(citizen_id: u4.id, bill_id: bill2.id, value: true)
Vote.create!(citizen_id: u5.id, bill_id: bill2.id, value: false)
Vote.create!(citizen_id: u1.id, bill_id: bill3.id, value: true)
Vote.create!(citizen_id: u2.id, bill_id: bill3.id, value: false)
Vote.create!(citizen_id: u3.id, bill_id: bill3.id, value: false)
Vote.create!(citizen_id: u4.id, bill_id: bill3.id, value: false)
Vote.create!(citizen_id: u1.id, bill_id: bill4.id, value: true)
Vote.create!(citizen_id: u2.id, bill_id: bill4.id, value: false)
Vote.create!(citizen_id: u3.id, bill_id: bill4.id, value: true)
Vote.create!(citizen_id: u4.id, bill_id: bill4.id, value: true)
Vote.create!(citizen_id: u5.id, bill_id: bill4.id, value: true)
Vote.create!(citizen_id: u6.id, bill_id: bill4.id, value: false)
Vote.create!(citizen_id: u7.id, bill_id: bill4.id, value: false)
Vote.create!(citizen_id: u8.id, bill_id: bill4.id, value: true)
Vote.create!(citizen_id: u1.id, bill_id: bill5.id, value: true)
Vote.create!(citizen_id: u2.id, bill_id: bill5.id, value: true)
Vote.create!(citizen_id: u3.id, bill_id: bill5.id, value: false)
Vote.create!(citizen_id: u4.id, bill_id: bill5.id, value: true)
Vote.create!(citizen_id: u5.id, bill_id: bill5.id, value: false)
Vote.create!(citizen_id: u1.id, bill_id: bill6.id, value: true)
Vote.create!(citizen_id: u2.id, bill_id: bill6.id, value: false)
Vote.create!(citizen_id: u3.id, bill_id: bill6.id, value: true)
Vote.create!(citizen_id: u4.id, bill_id: bill6.id, value: true)
Vote.create!(citizen_id: u5.id, bill_id: bill6.id, value: true)

Vote.create!(rep_id: greg.id, bill_id: bill4.id, value: true)
Vote.create!(rep_id: greg.id, bill_id: bill6.id, value: true)
Vote.create!(rep_id: greg.id, bill_id: bill5.id, value: true)