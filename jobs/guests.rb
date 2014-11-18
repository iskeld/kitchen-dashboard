guest_list = {
	'Michal Sliwon' => ['Tim Mast', 'Simo Saynevirta', 'Scot Burdette'], 
	'Magdalena Gonta-Rozniata' => ['Dario Tecci'],
	'Arkadiusz Kuczkowski' => ['Per Larsen']
	}

SCHEDULER.every '15s' do
	inviter = guest_list.keys.sample
	invitees = guest_list[inviter].join(", ")
	send_event('guests', {text: invitees, moreinfo: "Invited by " + inviter })
end
