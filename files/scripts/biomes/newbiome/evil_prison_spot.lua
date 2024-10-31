CHEST_LEVEL = 3
dofile_once("data/scripts/director_helpers.lua")
dofile_once("data/scripts/biome_scripts.lua")
dofile_once("data/scripts/lib/utilities.lua")

RegisterSpawnFunction( 0xffffeedd, "init" )
RegisterSpawnFunction( 0xffff5900, "spawn_check" )

function spawn_small_enemies( x, y ) end
function spawn_big_enemies( x, y ) end
function spawn_items( x, y ) end
function spawn_props( x, y ) end
function spawn_props2( x, y ) end
function spawn_props3( x, y ) end
function spawn_lamp( x, y ) end
function load_pixel_scene( x, y ) end
function load_pixel_scene2( x, y ) end
function spawn_unique_enemy( x, y ) end
function spawn_unique_enemy2( x, y ) end
function spawn_unique_enemy3( x, y ) end
function spawn_ghostlamp( x, y ) end
function spawn_candles( x, y ) end
function spawn_potions( x, y ) end
function spawn_wands( x, y ) end

function init( x, y, w, h )
	LoadPixelScene( "mods/Apotheosis/files/biome_impl/special_scenes/prison_spot.png", "mods/Apotheosis/files/biome_impl/special_scenes/prison_spot_visual.png", x, y, "", true )
end

function spawn_check(x, y)
	if tonumber(SessionNumbersGetValue("NEW_GAME_PLUS_COUNT")) <= 0 then
		EntityLoad( "data/entities/animals/boss_flesh_monster/inert/flesh_boss_inert.xml", x, y )
		EntityLoad( "data/entities/animals/boss_flesh_monster/inert/prison_check.xml", x, y )
	end
 -- this does exist!
end