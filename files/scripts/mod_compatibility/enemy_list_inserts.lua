
local insert_list = {
    {
        id_matchup="elk",
        name="cat_mocreeps\ncat_mocreeps_spoopy_skittle",
    },
    {
        id_matchup="eel",
        name="bubble_liquid",
    },
    --[[
    {
        id_matchup="fish_large",
        name="fish_red",
    },
    ]]--
    {
        id_matchup="miner_chef",
        name="hiisi_thief",
    },
    {
        id_matchup="shotgunner",
        name="hisii_minecart\nhisii_minecart_tnt\nhisii_giga_bomb",
    },
    {
        id_matchup="scavenger_glue",
        name="hisii_engineer",
    },
    {
        id_matchup="scavenger_shield",
        name="hisii_rocketshotgun",
    },
    {
        id_matchup="alchemist",
        name="hisii_hobo\nhisii_hobo_rich",
    },
    {
        id_matchup="shaman",
        name="shaman_greater_apotheosis",
    },
    {
        id_matchup="lasershooter",
        name="blindgazer",
    },
    {
        id_matchup="giantshooter",
        name="slime_leaker_weak\nslime_leaker\nslime_teleporter\ngoo_slug\nporing\nporing_magic\nporing_devil\nporing_holy\nporing_holy_arch",
    },
    {
        id_matchup="blob",
        name="blob_big\nblob_huge",
    },
    {
        id_matchup="ant",
        name="ant_fire\nant_suffocate",
    },
    {
        id_matchup="rat",
        name="rat_birthday",
    },
    {
        id_matchup="bigbat",
        name="ccc_bat_psychic",
    },
    {
        id_matchup="shooterflower",
        name="mudman_friendly",
    },
    {
        id_matchup="fungus",
        name="ceiling_fungus",
    },
    {
        id_matchup="ceiling_fungus",
        name="poisonmushroom",
    },
    {
        id_matchup="poisonmushroom",
        name="fungus_smoking_creep",
    },
    {
        id_matchup="fungus_giga",
        name="lukki_fungus",
    },
    {
        id_matchup="skullfly",
        name="hideous_mass",
    },
    {
        id_matchup="tentacler",
        name="tentacler_big",
    },
    {
        id_matchup="longleg",
        name="longleg_pillar",
    },
    {
        id_matchup="lukki_creepy_long",
        name="lukki_swarmling",
    },
    {
        id_matchup="lukki_dark",
        name="sunken_creature\nlukki_fire_miniboss_phase2\ngiant_centipede\nlocust_swarm\ndevourer_magic\nseeker\nminiboss_pit_02\nlukki_tentacle_hungry\nstar_child",
    },
    {
        id_matchup="worm_big",
        name="worm_wall",
    },
    {
        id_matchup="worm_end",
        name="worm_end_big_apotheosis\nworm_mechanical\nworm_spine",
    },
    {
        id_matchup="drone_physics",
        name="drone_status_ailment\ndrone_mini",
    },
    {
        id_matchup="drone_lasership",
        name="tesla_turret",
    },
    {
        id_matchup="basebot_soldier",
        name="c_basebot_speeder_apotheosis",
    },
    {
        id_matchup="tank_rocket",
        name="tank_flame_apotheosis",
    },
    {
        id_matchup="thunderskull",
        name="waterskull",
    },
    {
        id_matchup="firemage",
        name="wizard_firemage_greater",
    },
    {
        id_matchup="wizard_firemage_greater",
        name="watermage\nwatermage_greater",
    },
    {
        id_matchup="wizard_twitchy",    --Behold! 19 consecutive appends
        name="wizard_ambrosia\nwizard_copeseethmald\nwizard_duck\nenchanted_duck\nwizard_explosive\nwizard_jackofalltrades\nwizard_manaeater\nwizard_transmutation\nwizard_corrupt_wands\nwizard_z_poly_miniboss\nwizard_corrupt_ambrosia\nwizard_corrupt_hearty\nwizard_corrupt_manaeater\nwizard_corrupt_neutral\nwizard_corrupt_swapper\nwizard_corrupt_teleport\nwizard_corrupt_twitchy\nwizard_corrupt_weaken",
    },
    {
        id_matchup="wraith_glowing",
        name="wraith_alchemy_apotheosis\nwraith_returner_apotheosis\nwraith_weirdo_shield",
    },
    {
        id_matchup="hpcrystal",
        name="whisp\nwhisp_big\nwhisp_giga\nfairy_cheap\nfairy_big\nfairy_giant\nfairy_big_discord\nfairy_esoteric\nesoteric_being\nworm_esoteric",
    },
    {
        id_matchup="ethereal_being",
        name="musical_being\nmusical_being_weak",
    },
    {
        id_matchup="phantom_b",
        name="phantom_c_apotheosis\ndevourer_ghost\nghost_bow\nforsaken_eye",
    },
    {
        id_matchup="slimespirit",
        name="spirit_healing",
    },
    {
        id_matchup="gazer",
        name="gazer_greater",
    },
    {
        id_matchup="skygazer",
        name="gazer_greater_sky\ngazer_cold_apotheosis\ngazer_greater_cold\ngazer_parasitic\ngazer_robot",
    },
    {
        id_matchup="spitmonster",
        name="sentry\ntriangle_gem",
    },
    {
        id_matchup="skycrystal_physics",
        name="mimic_explosive_box",
    },
    {
        id_matchup="shaman_wind",
        name="mimic_perk_twwe",
    },
    {
        id_matchup="sniper_hell",
        name="hiisi_chef_hell",
    },
    {
        id_matchup="parallel_tentacles",
        name="boss_toxic_worm_parallel",
    },
    {
        id_matchup="friend",
        name="boss_toxic_worm\nboss_toxic_worm_minion\nboss_musical_ghost\nblob_titan\nboss_fire_lukki_phase2\nboss_flesh_monster\nforest_monolith",
    },
}


local path, enemies = "data/ui_gfx/animal_icons/_list.txt", {}
for enemy in ModTextFileGetContent(path):gmatch("[^\r\n]+") do
    enemies[#enemies+1] = enemy
end

-- Do your table shenanigans
if ModSettingGet( "Apotheosis.organised_icons" ) == true then
    for k=1,#insert_list
    do local v = insert_list[k]
        if v.id_matchup == nil then
            table.insert(enemies,v.name)
        else
            for z=1,#enemies
            do c = enemies[z]
                if c == v.id_matchup or z == #enemies then
                    table.insert(enemies,z + 1,v.name)
                    break
                end
            end
        end
    end
else
    for k=1,#insert_list
    do local v = insert_list[k]
        table.insert(enemies,v.name)
    end
end

ModTextFileSetContent(path, table.concat(enemies, "\n"))