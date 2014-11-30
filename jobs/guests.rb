require 'date'

guest_list = {
	'Petia Harlow' => {
		'guests' => ['Kelly Mu', 'Tayler Kim', 'Tafadzwa Shura'],
		'date' => (Date.parse('2014-11-20')..Date.parse('2014-12-11'))
	},
	'John Doe' => {
		'guests' => ['Fergie Montana'],
		'date' => (Date.parse('2014-11-20')..Date.parse('2014-12-11'))
	},
	'Hunter Jo' => {
		'guests' => ['Athaliah Ihsan'],
		'date' => (Date.parse('2014-11-20')..Date.parse('2014-12-11'))
	}
}
inviter_idx = 0

SCHEDULER.every '15s', :first_in => 0 do |job|

	today = Date.today
	todays_guests = guest_list.select { |k,v| v['date'] === today }

	if !todays_guests.empty?
		guests_today = todays_guests.keys.length
		
		if inviter_idx >= guests_today
			inviter_idx = 0
		end

		inviter = todays_guests.keys[inviter_idx]
		invitees = todays_guests[inviter]['guests']

		send_event('guests', { guests: invitees, moreinfo: "Invited by " + inviter })

		inviter_idx += 1
	else
		send_event('guests', { })
	end

end
