=begin
======================================================
  
  Map HUD v1.20
  by Adiktuzmiko                   
  
  Date Created: 01/21/2014
  Date Last Updated: 01/30/2014
  Requires: N/A
  Difficulty: Easy
  
======================================================
 Overview
======================================================
 
 This script allows you to display an in-map HUD for
 HP,MP,TP and EXP. 
 
 You can make it have a constant maximum
 width, or you can make the width scale with max HP/MP.
 You can use either images,single color or a dual color
 gradient for the bars. You can also have an image or
 color based background and icons for the bars.
 
======================================================
 Usage
====================================================== 

 Put this script into your scripts editor, probably
 below any other script that might modify Scene_Map
 and DataManager
 
 Modify the values in the module below to suit your
 needs
 
 Images should be placed in your game's Graphics/System
 folder
 
 To set which actor to show the HUD for, make a script call:
 
 ADIK::MAP_HUD.change_actor(actor_id)
 
 To turn on/off the HUD, make a script call:
 
 ADIK::MAP_HUD.toggle
 
 Take note that the HUD is off by default
 
 The actor and on/off settings are saved and loaded
 from your save file

======================================================
 Compatibility
======================================================

 Aliases DataManager's save/load methods, Scene_Title's
 start method, Scene_Map's start,update and pre terminate
 methods
 
======================================================
 Terms and Conditions
======================================================

 View it here: http://lescripts.wordpress.com/terms-and-conditions/

======================================================
=end


module ADIK
  module MAP_HUD
  #HUD modes
	#"constant" => maximum length of bars/gauges is constant
	#"scaling" => maximum length of bars/gauges scale depending on maximum
  MODE = "constant"
	#Maximum width of hp gauges : constant mode
	GAUGE_WIDTH_HP = 544/4
	#Height of hp gauges
	GAUGE_HEIGHT_HP = 10
	#Maximum width of mp gauges : constant mode
	GAUGE_WIDTH_MP = 544/4
	#Height of mp gauges
	GAUGE_HEIGHT_MP = 10
	#HP per pixel : scaling mode
	HP_PER_PIXEL = 10
	#MP per pixel : scaling mode
	MP_PER_PIXEL = 10
  #Maximum width of tp gauges : constant mode
	GAUGE_WIDTH_TP = 544/4
	#Height of tp gauges
	GAUGE_HEIGHT_TP = 10
  #Maximum width of exp gauges : all modes
	GAUGE_WIDTH_XP = 500
	#Height of exp gauges
	GAUGE_HEIGHT_XP = 10
  #TP per pixel : scaling mode
	TP_PER_PIXEL = 10
  #Show hp gauge?
  SHOW_HP = true
  #Show mp gauge?
  SHOW_MP = true
  #Show tp gauge?
  SHOW_TP = false
  #Show exp gauge?
  SHOW_XP = true
  #Font name used
  FONT = "VL Gothic"
  #Font size used
  FONT_SIZE = 18
  #Height buffer for the texts
  HP_BUFFER = 10
  MP_BUFFER = 10
  TP_BUFFER = 10
  XP_BUFFER = 10
  #The following draw varaibles can
  #be set to:
  #:both => draws current and max values
  #:current => draws current value
  #:max => draws max value
  #:percent => draws percentage value
  #:none => draw nothing
  #Draw HP text
  DRAW_HP = :both
  #Draw MP text
  DRAW_MP = :both
  #Draw TP text
  DRAW_TP = :none
  #Draw EXP text
  DRAW_XP = :percent
  #How many decimals to show for percent?
  DECIMALS = 2
	#Use gauge images?
	GAUGE_IMAGES = false
	#If true:
	  #HP Gauge background
	  GAUGE_BG_HP = ""
	  #MP Gauge background
	  GAUGE_BG_MP = ""
    #TP Gauge background
	  GAUGE_BG_TP = ""
    #XP Gauge background
	  GAUGE_BG_XP = ""
	  #HP Gauge image
	  GAUGE_HP = ""
	  #MP Gauge image
	  GAUGE_MP = ""
    #TP Gauge image
	  GAUGE_TP = ""
    #XP Gauge image
	  GAUGE_XP = ""
	#else
	  #Color.new(R,G,B,A)
	  #Set A to 0 if you want invisible
	  #HP Gauge background color
	  GAUGE_BGC_HP = Color.new(50,50,50,150)
	  #MP Gauge background color
	  GAUGE_BGC_MP = Color.new(50,50,50,150)
    #TP Gauge background color
	  GAUGE_BGC_TP = Color.new(0,0,0,0)
    #EXP Gauge background color
	  GAUGE_BGC_XP = Color.new(50,50,50,150)
	  #HP Gauge color
	  GAUGE_C_HP = Color.new(0,255,0,200)
	  #MP Gauge color
	  GAUGE_C_MP = Color.new(0,0,255,200)
    #TP Gauge color
	  GAUGE_C_TP = Color.new(0,0,0,0)
    #EXP Gauge color
	  GAUGE_C_XP = Color.new(200,200,0,255)
	  #Use gradient color?
	  GAUGE_GRADIENT = true
	  #HP Gauge color 2
	  GAUGE_C_HP_2 = Color.new(200,255,0,200)
	  #MP Gauge color 2
	  GAUGE_C_MP_2 = Color.new(200,0,255,200)
    #TP Gauge color 2
	  GAUGE_C_TP_2 = Color.new(0,0,0,0)
    #EXP Gauge color 2
	  GAUGE_C_XP_2 = Color.new(200,200,0,200)
	#end
  #Use icons?
  USE_ICONS = true
  #HP Icon index
  HP_ICON = 189
  #MP Icon Index
  MP_ICON = 188
  #TP Icon Index
  TP_ICON = 0
  #EXP Icon Index
  XP_ICON = 0
  #HP Icon alpha
  HP_ICON_ALPHA = 255
  #MP Icon alpha
  MP_ICON_ALPHA = 255
  #TP Icon alpha
  TP_ICON_ALPHA = 0
  #EXP Icon alpha
  XP_ICON_ALPHA = 0
	#X position of hp gauge
	X_HP = 24
	#Y position of hp gauge
	Y_HP = 9
	#X position of mp gauge
	X_MP = 24
	#Y position of mp gauge
	Y_MP = 34
  #X position of tp gauge
	X_TP = 24
	#Y position of tp gauge
	Y_TP = 60
  #X position of exp gauge
	X_XP = 22
	#Y position of xp gauge
	Y_XP = 416-16
  #X position of hp icon
	X_HP_ICON = 2
	#Y position of hp icon
	Y_HP_ICON = 1
	#X position of mp icon
	X_MP_ICON = 2
	#Y position of mp icon
	Y_MP_ICON = 26
  #X position of tp icon
	X_TP_ICON = 0
	#Y position of tp icon
	Y_TP_ICON = 0
  #X position of xp icon
	X_XP_ICON = 0
	#Y position of xp icon
	Y_XP_ICON = 0
	#Z of gauges
	GAUGES_Z = 500
	#Actor ID
	ACTOR = 1
  
  #Background properties
  #Not advisable for scaling mode
  
  #Background image, set to nil if you don't want it
  BACKGROUND = nil
  #Opacity of BACKGROUND
  OPACITY = 255
  #Use background color?
  USE_BG_COLOR = false
  #Background color, appears above image
  BG_COLOR = Color.new(50,50,50,100)
  #Use gradient color?
  BG_GRADIENT = false
  #2nd color, used for gradient
  BG_COLOR_2 = nil
  #X position of background
  BG_X = 0
  #Y position of background
  BG_Y = 0
  #Width of background
  BG_WIDTH = 165
  #Height of background
  BG_HEIGHT = 55
  
#==================================================================
# DO NOT EDIT BEYOND THIS POINT
#==================================================================
	
	def self.init
	  @use_hud = false
	  @viewport = Viewport.new(0,0,544,416)
    @viewport.z = GAUGES_Z
	  @sprite_bg = Sprite_Base.new(@viewport)
	  @sprite_bg.z = GAUGES_Z
	  @sprite_bg.bitmap = Bitmap.new(544,416)
	  @sprite_b = Sprite_Base.new(@viewport)
	  @sprite_b.z = GAUGES_Z+1
	  @sprite_b.bitmap = Bitmap.new(544,416)
	  if GAUGE_IMAGES
	    @hp_bg_bit = Cache.system(GAUGE_BG_HP)
		  @mp_bg_bit = Cache.system(GAUGE_BG_MP)
		  @hp_b_bit = Cache.system(GAUGE_HP)
		  @mp_b_bit = Cache.system(GAUGE_MP)
      @tp_bg_bit = Cache.system(GAUGE_BG_TP)
		  @tp_b_bit = Cache.system(GAUGE_TP)
      @xp_bg_bit = Cache.system(GAUGE_BG_XP)
		  @tp_b_bit = Cache.system(GAUGE_XP)
    end
    @bg = Cache.system(BACKGROUND) unless BACKGROUND.nil?
	  @hp = []
	  @mp = []
	  @maxhp = []
	  @maxmp = []
    @tp = []
    @exp = []
    @sprite_b.bitmap.font.name = FONT
    @sprite_b.bitmap.font.size = FONT_SIZE
	end
	
	def self.toggle
	  @use_hud = !@use_hud
	  if SceneManager.scene_is?(Scene_Map)
	    if @use_hud
	      self.update(true)
	    else 
	      @sprite_b.bitmap.clear
        @sprite_bg.bitmap.clear
	    end
	  end
	end
	
	def self.change_actor(id)
	  @actor = $game_actors[id]
	  self.update if SceneManager.scene_is?(Scene_Map)
	end
	
  def self.use_hud
    return @use_hud
  end
  
  def self.load_hud(wat)
    @use_hud = wat
  end
  
  def self.actor
    return @actor.id
  end
  
  def self.clear
    @sprite_b.bitmap.clear
    @sprite_bg.bitmap.clear
  end
  
	def self.update(forced=false)
	  unless forced
	    return if not @use_hud
	    return if not SceneManager.scene_is?(Scene_Map)
	    return if not @actor
	    return if (@actor.hp == @hp[@actor.id] and @actor.mp == @mp[@actor.id] and @actor.mhp == @maxhp[@actor.id] and @actor.mmp == @maxmp[@actor.id] and @actor.tp == @tp[@actor.id] and @actor.exp == @exp[@actor.id])
    end
	  @hp[@actor.id] = @actor.hp
	  @mp[@actor.id] = @actor.mp
	  @maxhp[@actor.id] = @actor.mhp
	  @maxmp[@actor.id] = @actor.mmp
    @tp[@actor.id] = @actor.tp
    @exp[@actor.id] = @actor.exp
	  @sprite_b.bitmap.clear
	  @sprite_bg.bitmap.clear
    rect_bg = Rect.new(BG_X,BG_Y,BG_WIDTH,BG_HEIGHT)
    if not @bg.nil?
      rect = Rect.new(0,0,@bg.width,@bg.height)
      @sprite_bg.bitmap.stretch_blt(rect_hp,@bg,rect,OPACITY)
    end
    if USE_BG_COLOR
      if BG_GRADIENT
        @sprite_bg.bitmap.gradient_fill_rect(rect_bg,BG_COLOR,BG_COLOR_2)
      else
        @sprite_bg.bitmap.fill_rect(rect_bg,BG_COLOR)
      end
    end
	  if MODE == "constant"
	    rect_hp = Rect.new(X_HP,Y_HP,GAUGE_WIDTH_HP,GAUGE_HEIGHT_HP)
	  	rect_mp = Rect.new(X_MP,Y_MP,GAUGE_WIDTH_MP,GAUGE_HEIGHT_MP)
      rect_tp = Rect.new(X_TP,Y_TP,GAUGE_WIDTH_TP,GAUGE_HEIGHT_TP)
	  else
	    rect_hp = Rect.new(X_HP,Y_HP,@actor.mhp/HP_PER_PIXEL,GAUGE_HEIGHT_HP)
		  rect_mp = Rect.new(X_MP,Y_MP,@actor.mmp/MP_PER_PIXEL,GAUGE_HEIGHT_MP)
      rect_tp = Rect.new(X_TP,Y_TP,100/TP_PER_PIXEL,GAUGE_HEIGHT_TP)
	  end
    rect_xp = Rect.new(X_XP,Y_XP,GAUGE_WIDTH_XP,GAUGE_HEIGHT_XP)
	  if GAUGE_IMAGES
      if SHOW_HP
	      rect = Rect.new(0,0,@hp_bg_bit.width,@hp_bg_bit.height)
        @sprite_bg.bitmap.stretch_blt(rect_hp,@hp_bg_bit,rect)
        rect = Rect.new(0,0,@hp_b_bit.width*@actor.hp_rate,@hp_b_bit.height)
        rect_hp.width *= @actor.hp_rate
        @sprite_b.bitmap.stretch_blt(rect_hp,@hp_b_bit,rect)
      end
      if SHOW_MP
        rect = Rect.new(0,0,@mp_bg_bit.width,@mp_bg_bit.height)
        @sprite_bg.bitmap.stretch_blt(rect_mp,@mp_bg_bit,rect)
        rect = Rect.new(0,0,@mp_b_bit.width*@actor.mp_rate,@mp_b_bit.height)
        rect_mp.width *= @actor.mp_rate
        @sprite_b.bitmap.stretch_blt(rect_mp,@mp_b_bit,rect)
      end
      if SHOW_TP
        rect = Rect.new(0,0,@tp_bg_bit.width,@tp_bg_bit.height)
        @sprite_bg.bitmap.stretch_blt(rect_tp,@tp_bg_bit,rect)
        rect = Rect.new(0,0,@tp_b_bit.width*@actor.tp_rate,@tp_b_bit.height)
        rect_tp.width *= @actor.tp_rate
        @sprite_b.bitmap.stretch_blt(rect_tp,@tp_b_bit,rect)
      end
      if SHOW_XP
        rect = Rect.new(0,0,@xp_bg_bit.width,@xp_bg_bit.height)
        @sprite_bg.bitmap.stretch_blt(rect_xp,@xp_bg_bit,rect)
        rect = Rect.new(0,0,@xp_b_bit.width*@actor.xp_rate,@xp_b_bit.height)
        rect_xp.width *= @actor.xp_rate
        @sprite_b.bitmap.stretch_blt(rect_xp,@xp_b_bit,rect)
      end
	  else
      @sprite_bg.bitmap.fill_rect(rect_hp,GAUGE_BGC_HP) if SHOW_HP
		  @sprite_bg.bitmap.fill_rect(rect_mp,GAUGE_BGC_MP) if SHOW_MP
      @sprite_bg.bitmap.fill_rect(rect_tp,GAUGE_BGC_TP) if SHOW_TP
      @sprite_bg.bitmap.fill_rect(rect_xp,GAUGE_BGC_XP) if SHOW_XP
		  rect_hp.width *= @actor.hp_rate
		  rect_mp.width *= @actor.mp_rate
      rect_tp.width *= @actor.tp_rate
      rect_xp.width *= @actor.exp_rate
		  if GAUGE_GRADIENT
		    @sprite_b.bitmap.gradient_fill_rect(rect_hp,GAUGE_C_HP,GAUGE_C_HP_2) if SHOW_HP
		    @sprite_b.bitmap.gradient_fill_rect(rect_mp,GAUGE_C_MP,GAUGE_C_MP_2) if SHOW_MP
        @sprite_b.bitmap.gradient_fill_rect(rect_tp,GAUGE_C_TP,GAUGE_C_TP_2) if SHOW_TP
        @sprite_b.bitmap.gradient_fill_rect(rect_xp,GAUGE_C_XP,GAUGE_C_XP_2) if SHOW_XP
      else
		    @sprite_b.bitmap.fill_rect(rect_hp,GAUGE_C_HP) if SHOW_HP
		    @sprite_b.bitmap.fill_rect(rect_mp,GAUGE_C_MP) if SHOW_MP
        @sprite_b.bitmap.fill_rect(rect_tp,GAUGE_C_TP) if SHOW_TP
		    @sprite_b.bitmap.fill_rect(rect_xp,GAUGE_C_XP) if SHOW_XP
		  end
	  end
    if USE_ICONS
        bitmap = Cache.system("Iconset")
        if SHOW_HP
          rect = Rect.new(HP_ICON % 16 * 24, HP_ICON / 16 * 24, 24, 24)
          @sprite_b.bitmap.blt(X_HP_ICON, Y_HP_ICON, bitmap, rect, HP_ICON_ALPHA)
        end
        if SHOW_MP
          rect = Rect.new(MP_ICON % 16 * 24, MP_ICON / 16 * 24, 24, 24)
          @sprite_b.bitmap.blt(X_MP_ICON, Y_MP_ICON, bitmap, rect, MP_ICON_ALPHA)
        end
        if SHOW_TP
          rect = Rect.new(TP_ICON % 16 * 24, TP_ICON / 16 * 24, 24, 24)
          @sprite_b.bitmap.blt(X_TP_ICON, Y_TP_ICON, bitmap, rect, TP_ICON_ALPHA)
        end
        if SHOW_XP
          rect = Rect.new(XP_ICON % 16 * 24, XP_ICON / 16 * 24, 24, 24)
          @sprite_b.bitmap.blt(X_XP_ICON, Y_XP_ICON, bitmap, rect, XP_ICON_ALPHA)
        end
    end
    if SHOW_HP and DRAW_HP != :none
      case DRAW_HP
      when :both
        @sprite_b.bitmap.draw_text(X_HP,Y_HP,GAUGE_WIDTH_HP,GAUGE_HEIGHT_HP + HP_BUFFER, @actor.hp.to_s + "/" + @actor.mhp.to_s)
      when :current
        @sprite_b.bitmap.draw_text(X_HP,Y_HP,GAUGE_WIDTH_HP,GAUGE_HEIGHT_HP + HP_BUFFER, @actor.hp.to_s)
      when :max
        @sprite_b.bitmap.draw_text(X_HP,Y_HP,GAUGE_WIDTH_HP,GAUGE_HEIGHT_HP + HP_BUFFER, @actor.mhp.to_s)
      when :percent
        @sprite_b.bitmap.draw_text(X_HP,Y_HP,GAUGE_WIDTH_HP,GAUGE_HEIGHT_HP + HP_BUFFER, get_decimal((@actor.hp*100/@actor.mhp).to_s) + "%")
      end
    end
    if SHOW_MP and DRAW_MP != :none
      case DRAW_MP
      when :both
        @sprite_b.bitmap.draw_text(X_MP,Y_MP,GAUGE_WIDTH_MP,GAUGE_HEIGHT_MP + MP_BUFFER, @actor.mp.to_s + "/" + @actor.mmp.to_s)
      when :current
        @sprite_b.bitmap.draw_text(X_MP,Y_MP,GAUGE_WIDTH_MP,GAUGE_HEIGHT_MP + MP_BUFFER, @actor.mp.to_s)
      when :max
        @sprite_b.bitmap.draw_text(X_MP,Y_MP,GAUGE_WIDTH_MP,GAUGE_HEIGHT_MP + MP_BUFFER, @actor.mmp.to_s)
      when :percent
        @sprite_b.bitmap.draw_text(X_MP,Y_MP,GAUGE_WIDTH_MP,GAUGE_HEIGHT_MP + MP_BUFFER, get_decimal((@actor.mp*100/@actor.mmp).to_s) + "%")
      end
    end
    if SHOW_TP and DRAW_TP != :none
      case DRAW_TP
      when :both
        @sprite_b.bitmap.draw_text(X_TP,Y_TP,GAUGE_WIDTH_TP,GAUGE_HEIGHT_TP + TP_BUFFER, @actor.tp.to_s + "/100" )
      when :current
        @sprite_b.bitmap.draw_text(X_TP,Y_TP,GAUGE_WIDTH_TP,GAUGE_HEIGHT_TP + TP_BUFFER, @actor.tp.to_s)
      when :max
        @sprite_b.bitmap.draw_text(X_TP,Y_TP,GAUGE_WIDTH_TP,GAUGE_HEIGHT_TP + TP_BUFFER, "100")
      when :percent
        @sprite_b.bitmap.draw_text(X_TP,Y_TP,GAUGE_WIDTH_TP,GAUGE_HEIGHT_TP + TP_BUFFER, get_decimal(@actor.tp.to_s) + "%")
      end
    end
    if SHOW_XP and DRAW_XP != :none
      case DRAW_XP
      when :both
        @sprite_b.bitmap.draw_text(X_XP,Y_XP,GAUGE_WIDTH_XP,GAUGE_HEIGHT_XP + XP_BUFFER, (@actor.exp-@actor.current_level_exp).to_s + "/" + (@actor.next_level_exp-@actor.current_level_exp).to_s)
      when :current
        @sprite_b.bitmap.draw_text(X_XP,Y_XP,GAUGE_WIDTH_XP,GAUGE_HEIGHT_XP + XP_BUFFER, (@actor.exp-@actor.current_level_exp).to_s)
      when :max
        @sprite_b.bitmap.draw_text(X_XP,Y_XP,GAUGE_WIDTH_XP,GAUGE_HEIGHT_XP + XP_BUFFER, (@actor.next_level_exp-@actor.current_level_exp).to_s)
      when :percent
        @sprite_b.bitmap.draw_text(X_XP,Y_XP,GAUGE_WIDTH_XP,GAUGE_HEIGHT_XP + XP_BUFFER, get_decimal((@actor.exp_rate*100).to_s) + "%")
      end
    end
	end
	
  def self.get_decimal(text)
    return text[0,text.index(".")+DECIMALS]
  end
  
  end
end

class Scene_Map

  alias start_adik_map_hud start
  def start
    start_adik_map_hud
    ADIK::MAP_HUD.update(true) if ADIK::MAP_HUD.use_hud
  end
  
  alias update_adik_map_hud update
  def update
    update_adik_map_hud
	  ADIK::MAP_HUD.update
  end

  alias terminate_adik_map_hud pre_terminate
  def pre_terminate
    terminate_adik_map_hud
    ADIK::MAP_HUD.clear if ADIK::MAP_HUD.use_hud
  end

end

class Scene_Title
  alias start_adik_map_hud start
  def start
    start_adik_map_hud
    ADIK::MAP_HUD.init
  end
end

module DataManager
  class <<self; alias make_save_contents_adik_map_hud make_save_contents; end
  def self.make_save_contents
    contents = make_save_contents_adik_map_hud
    contents[:use_adik_map_hud] = ADIK::MAP_HUD.use_hud
    contents[:actor_adik_map_hud] = ADIK::MAP_HUD.actor
    contents
  end
  
  class <<self; alias extract_save_contents_adik_map_hud extract_save_contents; end
  def self.extract_save_contents(contents)
    extract_save_contents_adik_map_hud(contents)
    ADIK::MAP_HUD.load_hud(contents[:use_adik_map_hud]) if contents[:use_adik_map_hud] != nil
    ADIK::MAP_HUD.change_actor(contents[:actor_adik_map_hud]) if contents[:actor_adik_map_hud] != nil
  end
end

class Game_Actor
  def exp_rate
    return (exp-current_level_exp).to_f/(next_level_exp-current_level_exp)
  end
end