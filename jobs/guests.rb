require 'date'

guest_list = {
	'Michal Sliwon' => {
		'guests' => ['Tim Mast', 'Simo Saynevirta', 'Scot Burdette'],
		'date' => (Date.parse('2014-11-20')..Date.parse('2014-11-21'))
	},
	'Magdalena Gonta-Rozniata' => {
		'guests' => ['Dario Tecci'],
		'date' => (Date.parse('2014-11-20')..Date.parse('2014-11-21'))
	},
	'Arkadiusz Kuczkowski' => {
		'guests' => ['Per Larsen'],
		'date' => (Date.parse('2014-11-20')..Date.parse('2014-11-21'))
	}
}

SCHEDULER.every '15s' do
	today = Date.today

	list = guest_list.select{|k,v| v['date'] === today}

	inviter = list.keys.sample
	invitees =  list[inviter]['guests']

	send_event('guests', {items: invitees, moreinfo: "Invited by " + inviter })
end
