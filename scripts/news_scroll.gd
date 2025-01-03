extends CanvasLayer

@onready var news_scroll: ScrollContainer = $TextureRect/newsScroll
@onready var timer: Timer = $Timer
@onready var appear_scroll_timer: Timer = $appear_scroll_timer
@onready var label: Label = $TextureRect/newsScroll/Label
@onready var texture_rect: TextureRect = $TextureRect

var news_stories = ["Anton was sent to correction camp for pouring milk before cereal"
, "Ruby has been executed by 28 stabwoonds for hating on popular AAA game. King Eksyliush's comment: 'Now you know why this scene was tragic you uncultured critter'"
, "Matt has been sentences to 'PUNISHMENT' for commiting 'CRIME'", "X has been sentenced to head shaving for waring buzz cut"
, "Veronica was executed by beheading for saying 'I'll be heading home'. That's nothing bad, King Eksyliush just thought it would be funny. "
, "Adam was sentenced to life of using nokia 3310 as their phone for cracking the screen on the new IPhone. "
, "Rebeca has been sentenced to death by hanging for hanging around bad people."
, "John has been sentenced to month of wearing a cloth gag for having an annoying accent."
, "Merry has been sentenced to ejection for being among us."
, "The musical classes in any and all schools now have to teach playing Motzar's symphonies on a musical triangle "
, "All schools now have to replace christisn crosses with images of Jesus. Unbemouced to them, its just Radek Klasa's photos. "
, "Jeff has been executed by burning on a stake for playing a fire song at a government building "
, "King Eksyliush enforced a new regulation. 75% of all grape fruit juice produced now go to him. The reason given: 'I got no gifts for my birthday' "
, "King Eksyliush just gave an annoucment: 'Yo mama so fat she bigger than the 8 Floor Maschine"]
 #Taunty: 'Are you an electrical outlet? Because I want to stab you with a metal fork' "
#, "'You remind me of my hamster... he kept on biting my heels' "
#, "'You're like Windows 11. I'll leave it at that' "
#, "'You've gotta be really gridy to want my throne... so I'll hit a griddy once you're dead' "
#, "'Sorry for being so quiet sometimes. I am just taking time with more importsnt tasks than you, like playing ping-pong online'"]
var just_changed = false


# Called when the node enters the scene tree for the first time.
func _ready():
	texture_rect.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if just_changed:
		news_scroll.scroll_horizontal += 1


func _on_timer_timeout() -> void:
	just_changed = false
	texture_rect.visible = true
	GameManager.new_annoucement.emit(4)
	news_scroll.scroll_horizontal = 0
	label.text = news_stories.pick_random()
	appear_scroll_timer.start()
	await get_tree().create_timer(2.).timeout
	just_changed = true


func _on_appear_scroll_timer_timeout() -> void:
	texture_rect.visible = false
	pass # Replace with function body.
