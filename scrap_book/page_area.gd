class_name Page extends Node2D

@onready var sprite_2d_left: Sprite2D = %Sprite2D_Left
@onready var sprite_2d_right: Sprite2D = %Sprite2D_Right
@onready var page_text: RichTextLabel = %PageText
@onready var page_num: Label = %PageNum

var _page : PageModel

func apply_page(page: PageModel) -> void:
	_page = page
	set_visible(_page != null)
	if _page == null: 
		return
		
	var side := _page.get_side() 
	page_text.set_text(_page.get_page_text())
	page_num.set_text(str(_page.get_page_number()))
	
	sprite_2d_left.set_visible(side == Vector2i.LEFT)
	sprite_2d_right.set_visible(side == Vector2i.RIGHT)
	
	if side == Vector2i.LEFT:
		page_num.set_horizontal_alignment(HORIZONTAL_ALIGNMENT_LEFT)
		page_text.position.x = -225
	else: # RIGHT
		page_num.set_horizontal_alignment(HORIZONTAL_ALIGNMENT_RIGHT)
		page_text.position.x = 25
	
