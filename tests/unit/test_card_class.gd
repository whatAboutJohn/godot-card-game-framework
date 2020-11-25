extends "res://tests/UTcommon.gd"

var card: Card
var cards := []

func before_each():
	setup_board()
	card = cfc.NMAP.deck.get_card(0)

func test_methods():
	assert_eq('Card',card.get_class(), 'class name returns correct value')

func test_focus_setget():
	card.set_focus(true)
	card.state = 1
	assert_true(card.get_node('Control/FocusHighlight').visible,
			'Highlight is set correctly to visible')
	assert_true(card.get_focus(),
			'get_focus returns true correct value correctly')
	card.set_focus(false)
	card.state = 0
	assert_false(card.get_node('Control/FocusHighlight').visible,
			'Highlight is set correctly to invisible')
	assert_false(card.get_focus(),
			'get_focus returns false correct value correctly')

func test_move_to():
	var discard : Pile = cfc.NMAP.discard
	var card2 = cfc.NMAP.deck.get_card(1)
	var card3 = cfc.NMAP.deck.get_card(2)
	var card4 = cfc.NMAP.deck.get_card(3)
	var card5 = cfc.NMAP.deck.get_card(4)
	var card6 = cfc.NMAP.deck.get_card(5)
	card.move_to(discard)
	card2.move_to(discard)
	assert_eq(1,discard.get_card_index(card2),
			'move_to without arguments puts card at the end')
	card3.move_to(discard, 0)
	assert_eq(0,discard.get_card_index(card3),
			'move_to can move card to the top')
	card4.move_to(discard, 2)
	assert_eq(2,discard.get_card_index(card4),
			'move_to can move card between others')
	card5.move_to(discard,2)
	card6.move_to(discard,2)
	assert_eq(2,discard.get_card_index(card6),
			'move_to can takeover/push index spots of other cards')
	assert_eq(3,discard.get_card_index(card5),
			'move_to can takeover/push index spots of other cards')
	assert_eq(4,discard.get_card_index(card4),
			'move_to can takeover/push index spots of other cards')

func test_init_card_name():
	# We know which are the last 3 card types of the test cards
	var test3 = cfc.NMAP.deck.get_card(14)
	var test2 = cfc.NMAP.deck.get_card(13)
	var test1 = cfc.NMAP.deck.get_card(12)
	assert_eq("Test Card 1",test1.card_name,
			'card_name variable is set correctly')
	assert_string_contains(test1.name, "Test Card 1")
	assert_eq("Test Card 1",test1.get_node("Control/Front/CardText/Name").text,
			'Name Label text is set correctly')
	assert_eq("Test Card 2",test2.card_name,
			'card_name variable is set correctly')
	assert_string_contains(test2.name, "Test Card 2")
	assert_eq("Test Card 2",test2.get_node("Control/Front/CardText/Name").text,
			'Name Label text is set correctly')
	assert_eq("Test Card 3",test3.card_name,
			'card_name variable is set correctly')
	assert_string_contains(test3.name, "Test Card 3")
	assert_eq("Test Card 3",test3.get_node("Control/Front/CardText/Name").text,
			'Name Label text is set correctly')

func test_card_name_setget():
	card.set_name("Testing Name Change 1")
	assert_eq("Testing Name Change 1",card.card_name,
			'card_name variable is set correctly')
	assert_string_contains(card.name, "Testing Name Change 1")
	assert_eq("Testing Name Change 1",card.get_node("Control/Front/CardText/Name").text,
			'Name Label text is set correctly')
	card.card_name = "Testing Name Change 2"
	assert_eq("Testing Name Change 2",card.card_name,
			'card_name variable is set correctly')
	assert_string_contains(card.name, "Testing Name Change 2")
	assert_eq("Testing Name Change 2",card.get_node("Control/Front/CardText/Name").text,
			'Name Label text is set correctly')
