dofile_once("data/scripts/lib/utilities.lua")

--local modCompatibilityConjurer = ModSettingGet( "Apotheosis.mod_compat_mode_conjurer" )
local modCompatibilitySpellEvolutions = ModSettingGet("Apotheosis.mod_compat_mode_spell_evolution")
local motdSetting = ModSettingGet("Apotheosis.motd_setting")
local seasonalSetting = ModSettingGet("Apotheosis.seasonal_events")
local spoopyGFXSetting = ModSettingGet("Apotheosis.spoopy_graphics")

local seasonalForced_AprilFools = ModSettingGet("Apotheosis.seasonal_events_forced_april_fools")
local seasonalForced_Birthday = ModSettingGet("Apotheosis.seasonal_events_forced_birthday")
local seasonalForced_Halloween = ModSettingGet("Apotheosis.seasonal_events_forced_halloween")
local seasonalForced_Smissmass = ModSettingGet("Apotheosis.seasonal_events_forced_smissmass")

local experimental_biomemap = ModSettingGet("Apotheosis.exp_biomemap")

local capeSetting = ModSettingGet("Apotheosis.secret_golden_cape")

--Debug flag removals, be sure to remove before release!!!
--RemoveFlagPersistent( "apotheosis_card_unlocked_secret_knowledge_of_kings" )
--RemoveFlagPersistent( "apotheosis_card_unlocked_secret_knowledge_of_kings_spell" )

--Spawn Bosses

--This was a coding marathon and a half, huge shoutouts to Horscht for the help on this one.
--And Zathers for making this lua file
--Note: This has been moved lower down for cleaner organisation & implementing mod compatibility
--Note: 16/06/2023 Some boss spawns may be moved into biome files as well



-- Spell Unlock Fixes
-- If someone attains a spell through another mod, twitch integration, etc, this is just to make sure they aren't getting unlocks they shouldn't.
-- They'll still get the spell, it just won't be added to their permanent record
-- Rat bite isn't "verified" because it's a funny spell

-- Protect spell progress in case of accidental unlocks
do
  for _, entry in ipairs({
    "divinebeing",
    "boss_toxic_worm",
    "musical_boss",
    "blob_boss",
    "fire_lukki",
    "boss_flesh_monster",
    "cat_secret",
    "orb_12",
    "orb_14",
    "orb_15",
    "orb_16",
    "lost_alchemy",
    "omega_cross",
  }) do
    local progressflag = "apotheosis_card_unlocked_" .. entry
    if HasFlagPersistent( progressflag ) then
      AddFlagPersistent( progressflag .. "_spell" )
    else
      RemoveFlagPersistent( progressflag .. "_spell" )
    end
  end
end

--Ending Reward
if HasFlagPersistent("apotheosis_card_unlocked_ending_apotheosis_02") then
	AddFlagPersistent("apotheosis_card_unlocked_ending_apotheosis_02_spell")
else
	RemoveFlagPersistent("apotheosis_card_unlocked_ending_apotheosis_02_spell")
end

--Ensure this flag is never enabled, so spells can properly be disabled in hardcore mode while still appearing in the progress log
RemoveFlagPersistent("this_should_never_spawn")











--Description fix for Ghostly Vision Perk
--Wow, I've come a long way since then.
--Thankyou for all the help, gamers!

local content = ModTextFileGetContent("data/translations/common.csv")
ModTextFileSetContent("data/translations/common.csv", content .. [[
,en,ru,pt-br,es-es,de,fr-fr,it,pl,zh-cn,jp,ko,,NOTES – use \n for newline,max length
perk_apotheosis_ghostly_vision,Ghostly Vision,Призрачное зрение,,,,,,,看清幽灵,霊感,,,,
perk_apotheosis_ghostly_vision_description,You can see things which aren't there.. Without assistance.,"Вы можете видеть вещи, которых тут нет... Без посторонней помощи.",,,,,,,你可以看到不存在的事物.. 并且不需要借助任何东西。,見えないものが見えるようになる,,,,
perk_apotheosis_ghostly_vision,Ghostly Vision,Призрачное зрение,,,,,,,看清幽灵,霊感,,,,
perk_apotheosis_ghostly_vision_description,You can see things which aren't there.. Without assistance.,"Вы можете видеть вещи, которых тут нет... Без посторонней помощи.",,,,,,,你可以看到不存在的事物.. 并且不需要借助任何东西。,見えないものが見えるようになる,,,,
perk_apotheosis_rage_aura,Enraging Aura,Раздражающая аура,,,,,,,激怒气场,オラオラオーラ,,,,
perk_apotheosis_rage_aura_description,Creatures are sent into a blind rage by your presence.,От вашего присутствия существа впадают в слепую ярость.,,,,,,,你的存在令周围的生物陷入盲目的愤怒,周囲の生物が激しく怒り出す,,,,
book_apotheosis_divine_liquid,Tablet of Apotheosis,Скрижаль Апофеоза,,,,,,,翡翠石板 - 神化,神性の碑文,,,,
book_apotheosis_divine_liquid_description,"Long have been the days since the universe was in union. \nWhen Slime was no different from above and below was no different from slime. \nSome species have adapted to these changes however, excessively, and became attuned to the pinnacles and depths of this world. \nThey must distance themselves with truly divine purpose.","Давно прошли те дни, когда вселенная была в единстве. \nКогда слизь не отличалась от верха, а низ не отличался от слизи. \nНекоторые виды, однако, чрезмерно приспособились к этим изменениям и стали сонастроены с вершинами и глубинами этого мира. \nОни должны отдаляться с истинно божественной целью.",,,,,,,宇宙如一的日子早已不再。\n彼时，上方粘液怪如同下方，下方的粘液怪亦无异于上方。\n如今，有些物种适应了世界的变化，却过为已甚，竟与这个世界的高峰和深谷相协。\n它们必须与真正的神圣目的保持距离。,,,,,
book_apotheosis_materia_conversion_description,"Transmutation.. Materia Conversion. \nFor years I've dedicated my life to this art, only to foolishly trick myself. \nFor years I thought Materia Conversion could only be used on solid matter, \nBut only now in my last few days I've come to learn it can be harnessed on magic as well. \nI can only hope the fruits of my labour will not be forgotten.","Трансмутация. Превращение материи. \nГодами я посвящал свою жизнь этому искусству, но только для того, чтобы обмануть самого себя. \nДолгие годы я думал, что преобразование материи можно использовать только в твёрдой материи, \nНо только теперь, в последние дни, я узнал, что его можно использовать и в магии. \nОстаётся надеяться, что плоды моего труда не будут забыты.",,,,,,,"金属嬗变...物质转换。\n多年来我一直致力于这项技艺，到头来却只是被自己的愚蠢所蒙蔽。\n这么多年，我以为物质转换只能用于固体物质，\n但直到现在，在我最后的时日,方才明白它也可以用于魔法。\n我希望我的研究成果不会被遗忘。",,,,,
book_apotheosis_trophy_room,Alchemist's Notes,Записи алхимика,,,,,,,炼金术士的笔记,錬金術師のメモ,,,,
book_apotheosis_trophy_room_description,"I have come to learn this Tree was deemed unfitting of.. certain.. accomplishments by the gods. \nCross the lava, descend where you would not normal. \nThere they will humour you.","Я узнал, что боги сочли это Дерево непригодным для... определённых... свершений. \nПересеките лаву, спуститесь туда, куда обычно не спускаются. \nТам они будут над вами насмехаться.",,,,,,,"我得知""树""被众神认为不适合完成某些任务。\n穿过熔岩，下到你从未敢下之处。\n然后众神将会取笑你。",,,,,
book_apotheosis_trophy_room_description_purgatory,"I have come to learn this Tree was deemed unfitting of.. certain.. accomplishments by the gods. \nSpelunk east before you visit their place of worship, cross the fungus, holding the ceiling dear. \nThere they will humour you.","Я узнал, что боги сочли это Дерево непригодным для... определённых... свершений. \nСпешите на Восток, прежде чем посетить место их поклонения, перейдите по грибку, держась за потолок. \nТам они будут над вами насмехаться.",,,,,,,"我得知""树""被众神认为不适合完成某些任务。\n在你拜访他们的崇拜之地之前，向东钻过洞穴，穿过真菌，爬上天花板。\n然后众神将会取笑你。",,,,,
mat_cloth,Cloth,Ткань,,,,,,,布,布,,,,
book_apotheosis_cat_rat,Cat Lover's Notes,Записи любителя кошек,,,,,,,爱猫者的笔记,ネコ愛好家のメモ,,,,
book_apotheosis_cat_rat_description,My cats seem scared of normal rats.. \nBut have an irresistible hate towards magical rats for some reason. \nIt's kind of cute.. But I can't brush away the feeling they distance themselves with truly divine purpose...,"Мои кошки боятся обычных крыс... \nНо почему-то испытывают непреодолимую ненависть к магическим крысам. \nЭто даже мило... Но я не могу избавиться от ощущения, что они отдаляются от меня с поистине божественной целью...",,,,,,,我的猫咪们似乎害怕普通的老鼠...\n却不知为何对魔法老鼠有着无法抑制的仇恨。\n这有点可爱...但它们因真正的神圣目的而离开时的那种感觉，\n却在我脑海中始终挥之不去...,,,,,
item_apotheosis_chest_cursed,Pandora's Chest,Сундук Пандоры,,,,,,,潘多拉的箱子,パンドラの箱,,,,
status_apotheosis_magicwet_ui,Magical Wetness,Магическая влажность,,,,,,,潮湿（魔法）,魔法の水濡れ,,,,
statusdesc_apotheosis_magicwet_ui,Wet clothes protect you from fire.,Мокрая одежда защищает вас от огня.,,,,,,,潮湿的衣服可保护你免受火焰伤害,服がずぶ濡れだ。火には強そう。,,,,
status_apotheosis_magicfire_ui,Magical Fire,Волшебный огонь,,,,,,,着火（魔法）,魔法の炎,,,,
statusdesc_apotheosis_magicfire_ui,You're on fire! Find water quickly!,Вы горите! Быстро найдите воду!,,,,,,,你着火了。快去找水来！,服に火が付いた！水を被らなくては！,,,,
status_apotheosis_magicurine_ui,Magical Jarate,Волшебный Банкате,,,,,,,瓶手道（魔法）,魔法の尿濡れ,,,,
statusdesc_apotheosis_magicurine_ui,Wet clothes protect you from fire. \nYou sense an increased chance of receiving critical strikes.,Мокрая одежда защищает вас от огня. \nВы чувствуете повышенную вероятность получения критических попаданий по себе.,,,,,,,潮湿的衣服可保护你免受火焰伤害。\n你感觉自己更容易被打出暴击。,服がずぶ濡れだ。火には強そう。敵の攻撃がクリティカルヒットする確率が上昇している。,,,,
status_apotheosis_magicpolymorph_ui,Magical Polymorph,Волшебный полиморфизм,,,,,,,混乱变形（魔法）,魔法の多形濡れ,,,,
statusdesc_apotheosis_magicpolymorph_ui,You have been polymorphed into a vulnerable sheep!,Вы превратились в беззащитную овцу!,,,,,,,你成了一只小绵羊。,か弱い子羊になってしまった。,,,,
log_apotheosis_reality_mutation_00,YOU SENSE THE REALITY HAS SHIFTED,"ВЫ ЧУВСТВУЕТЕ, ЧТО В РЕАЛЬНОСТИ ЧТО-ТО СМЕСТИЛОСЬ",,,,,,,你感觉到现实受到了变换,世界が転移した！,,,,
log_apotheosis_reality_mutation_01,YOU FEEL THE WORLD'S CREATURES HAVE CHANGED,"ВЫ ЧУВСТВУЕТЕ, ЧТО СУЩЕСТВА МИРА ИЗМЕНИЛИСЬ",,,,,,,你感觉到生命的法则发生了改变,数多の生命がその姿を変えていく！,,,,
log_apotheosis_reality_mutation_02,THE WORLD'S LIFE HAS BEEN SHAKEN,ЖИЗНЬ МИРА ПОШАТНУЛАСЬ,,,,,,,生命的法则受到了动摇,生命たちの存在が揺らいでいる！,,,,
log_apotheosis_reality_mutation_03,YOU SENSE THE PATH OF EVOLUTION HAS CHANGED,"ВЫ ЧУВСТВУЕТЕ, ЧТО ПУТЬ ЭВОЛЮЦИИ ИЗМЕНИЛСЯ",,,,,,,你感觉到生命的演化走上了一条不同的路,進化の道筋が変わっていく！,,,,
log_apotheosis_reality_mutation_04,YOU FEEL REALITY HAS BEEN ALTERED,"ВЫ ЧУВСТВУЕТЕ, ЧТО В РЕАЛЬНОСТИ ЧТО-ТО ИЗМЕНИЛОСЬ",,,,,,,你感觉到现实受到了更改,世界が姿を変えてしまった！,,,,
log_apotheosis_reality_mutation_05,YOU FEEL LIFE IN THE COSMOS HAS SHIFTED,"ВЫ ЧУВСТВУЕТЕ, ЧТО ЖИЗНЬ В КОСМОСЕ СДВИНУЛАСЬ",,,,,,,你感觉到生命的运行规律受到了变换,宇宙の法則が乱れる！,,,,
material_apotheosis_meat_irritating,Irritating Meat,Раздражающее мясо,,,,,,,刺鼻的肉,イライラ肉,,,,
material_apotheosis_meat_decaying,Decaying Meat,Разлагающееся мясо,,,,,,,腐烂的肉,腐食の肉,,,,
material_apotheosis_meat_feathery,Feathery Meat,Пернатое мясо,,,,,,,带羽的肉,フワフワ肉,,,,
material_apotheosis_meat_centipede,Centipede Meat,Мясо сороконожки,,,,,,,蜈蚣的肉,ムカデの肉,,,,
material_apotheosis_sand_pink,Pink Sand,Розовый песок,,,,,,,粉砂,ピンクの粉末,,,,
material_apotheosis_sand_red,Red Sand,Синий песок,,,,,,,红砂,赤い粉末,,,,
material_apotheosis_sand_insect_husk,Insect Husk,Шелуха насекомого,,,,,,,虫壳,甲虫の殻,,,,
material_apotheosis_mist_poison,Poisonous Mist,Ядовитый туман,,,,,,,毒雾,ポイズンミート,,,,
material_apotheosis_gem_green,Green Gem,Зелёный самоцвет,,,,,,,绿色宝石,緑の宝玉,,,,
material_apotheosis_magic_divine_liquid,Divine Liquid,Божественная жидкость,,,,,,,神圣液体,聖なる液体,,,,
material_apotheosis_spark_orange,Orange Spark,Оранжевая искра,,,,,,,橙色火花,オレンジの火花,,,,
material_apotheosis_blood_centipede,Centipede Blood,Кровь сороконожки,,,,,,,蜈蚣血液,ムカデの血,,,,
spell_apotheosis_thrower_disc_name,Giga Disc Projectile Thrower,Метатель гигантских дисков,,,,,,,终极锯片发射器,ギガディスクスローワー,,,,
spell_apotheosis_thrower_disc_desc,Makes a projectile cast Giga Disc Projectiles in random directions,Снаряд испускает гигантские дисковые снаряды в случайном направлении,,,,,,,令投射物向随机方向发射终极锯片,放射物が周囲にギガディスクを発射するようになる。,,,,
spell_apotheosis_thrower_cursed_orb_name,Cursed Orb Thrower,Метатель проклятых сфер,,,,,,,诅咒之球发射器,呪われたオーブスローワー,,,,
spell_apotheosis_thrower_cursed_orb_desc,Makes a projectile cast Cursed Orbs in random directions,Снаряд испускает проклятые шары в случайном направлении,,,,,,,令投射物向随机方向发射诅咒之球,放射物が周囲に呪われたオーブを発射するようになる。,,,,
spell_apotheosis_thrower_tnt_name,Dynamite Thrower,Метатель динамита,,,,,,,炸药发射器,TNTスローワー,,,,
spell_apotheosis_thrower_tnt_desc,Makes a projectile cast Dynamite in random directions,Снаряд испускает динамит в случайном направлении,,,,,,,令投射物向随机方向发射炸药,放射物が周囲にTNTを発射するようになる。,,,,
spell_apotheosis_thrower_ice_ball_name,Ice Ball Thrower,Метатель ледяных шариков,,,,,,,冰球发射器,氷の玉スローワー,,,,
spell_apotheosis_thrower_ice_ball_desc,Makes a projectile cast Ice Balls in random directions,Снаряд испускает ледяные шарики в случайном направлении,,,,,,,令投射物向随机方向发射冰球,放射物が周囲に氷の玉を発射するようになる。,,,,
spell_apotheosis_thrower_nuke_name,Nuke Thrower,Метатель ядерного оружия,,,,,,,核弹发射器,核爆弾スローワー,,,,
spell_apotheosis_thrower_nuke_desc,Are you sure?,Вы уверены?,,,,,,,你确定？,これ撃つの？マジ？,,,,
spell_apotheosis_thrower_disc_enemy_name,Personal Giga Disc Projectile Thrower,Личный метатель гигантских дисков,,,,,,,专属巨型锯片发射器,パーソナルギガディスクスローワー,,,,
spell_apotheosis_thrower_disc_enemy_desc,Makes a projectile turn the creatures it hits into living Sawblade throwers,"Снаряд превращает существ, с которыми сталкивается, в метателей пил",,,,,,,令投射物击中的生物变成活着的巨型锯片发射器,放射物の当たった敵が周囲にギガディスクを発射するようになる。,,,,
spell_apotheosis_thrower_cursed_orb_enemy_name,Personal Cursed Orb Thrower,Личный метатель проклятых сфер,,,,,,,专属诅咒之球发射器,パーソナル呪われたオーブスローワー,,,,
spell_apotheosis_thrower_cursed_orb_enemy_desc,Makes a projectile turn the creatures it hits into living Cursed Orb throwers,"Снаряд превращает существ, с которыми сталкивается, в метателей проклятых сфер",,,,,,,令投射物击中的生物变成活着的诅咒之球发射器,放射物の当たった敵が周囲に呪われたオーブを発射するようになる。,,,,
spell_apotheosis_thrower_ice_ball_enemy_name,Personal Ice Ball Thrower,Личный метатель ледяных шариков,,,,,,,专属冰球发射器,パーソナル氷の玉スローワー,,,,
spell_apotheosis_thrower_ice_ball_enemy_desc,Makes a projectile turn the creatures it hits into living Ice Ball throwers,"Снаряд превращает существ, с которыми сталкивается, в метателей ледяных шариков",,,,,,,令投射物击中的生物变成活着的冰球发射器,放射物の当たった敵が周囲に呪われたオーブを発射するようになる。,,,,
spell_apotheosis_thrower_tnt_enemy_name,Personal Dynamite Thrower,Личный метатель динамита,,,,,,,专属炸药发射器,パーソナルTNTスローワー,,,,
spell_apotheosis_thrower_tnt_enemy_desc,Makes a projectile turn the creatures it hits into living Dynamite throwers,"Снаряд превращает существ, с которыми сталкивается, в метателей динамита",,,,,,,令投射物击中的生物变成活着的炸药发射器,放射物の当たった敵が周囲にTNTを発射するようになる。,,,,
spell_apotheosis_thrower_nuke_enemy_name,Personal Nuke Thrower,Личный метатель ядерного оружия,,,,,,,专属核弹发射器,パーソナル核爆弾スローワー,,,,
spell_apotheosis_thrower_nuke_enemy_desc,Makes a projectile turn the creatures it hits into living... Nuke throwers?!?!!,"Снаряд превращает существ, с которыми сталкивается, в... метателей ядерного оружия?!?!!",,,,,,,令投射物击中的生物变成活着的...核弹(?!)发射器,放射物の当たった敵が発射するようになる……核爆弾を！？,,,,
spell_apotheosis_holy_orb_barrage_name,Holy Orb Barrage,Шквал священных сфер,,,,,,,圣球之幕,聖なる弾幕,,,,
spell_apotheosis_holy_orb_barrage_desc,Casts a barrage of 7 holy orbs. Also has some magical properties...,Вызывает шквал из 7 святых шаров. Также обладает некоторыми магическими свойствами...,,,,,,,施放由 7 个神圣法球组成的弹幕。同时也有一些魔法属性...,7発の聖なる弾を発射する。若干の魔法特性もある。,,,,
spell_apotheosis_cursed_orb_barrage_name,Cursed Orb Barrage,Шквал проклятых сфер,,,,,,,邪球之幕,邪悪な弾幕,,,,
spell_apotheosis_cursed_orb_barrage_desc,Casts a barrage of 7 cursed orbs. Has some noticeably destructive properties.,Вызывает шквал из 7 проклятых шаров. Обладает заметными разрушительными свойствами.,,,,,,,施放由 7 个邪恶法球组成的弹幕。具有一些明显的破坏属性。,7発の邪悪な弾を発射する。強力な破壊の力を秘めている。,,,,
spell_apotheosis_giga_bomb_name,Giga Bomb,Большая бомба,,,,,,,巨型炸弹,ギガボム,,,,
spell_apotheosis_giga_bomb_desc,Explosion!!,Бум!!,,,,,,,ExpIosion！！,エクスプロージョン！！,,,,
spell_apotheosis_aqua_mine_name,Aqua Mine,Водяная мина,,,,,,,水雷,機雷,,,,
spell_apotheosis_aqua_mine_desc,Creates an explosive Aquamine with subtle homing properties.,Создёет взрывоопасную водяную мину с тонкими свойствами самонаведения.,,,,,,,创造一个缓缓追踪敌人的爆炸性水雷投射物。,浮遊する機雷を設置する。ホーミング性能が少しある。,,,,
spell_apotheosis_mass_materia_conversion_name,Mass Materia Conversion,Массовое преобразование материалов,,,,,,,群体物质转换,マテリア変換,,,,
spell_apotheosis_mass_materia_conversion_desc,Cave quid volunt,Cave quid volunt,,,,,,,小心欲望的洪流！,Cave quid volunt(欲望に流されるべからず),,,,
spell_apotheosis_bungal_shift_name,Fungal Shift,Грибковое смещение,,,,,,,真菌转换,きのこシフト,,,,
spell_apotheosis_bungal_shift_desc,Cave quid volunt,Cave quid volunt,,,,,,,小心欲望的洪流！,Cave quid volunt(欲望に流されるべからず),,,,
spell_apotheosis_musical_proj_name,Musical Strike,Музыкальный удар,,,,,,,音乐打击,ミュージックストライク,,,,
spell_apotheosis_musical_proj_desc,"Fires a powerful musical attack, careful not to lose your creativity","Стреляет мощной музыкальной атакой, стараясь не потерять свой творческий потенциал",,,,,,,射出一股强力的音乐攻击，小心不要失去你的创造力,音楽のパワーで攻撃する。芸術は爆発だ！,,,,
spell_apotheosis_musical_proj_trig_name,Musical Strike with trigger,Музыкальный удар с активацией,,,,,,,带有触发的音乐打击,トリガー付きミュージックストライク,,,,
spell_apotheosis_musical_proj_trig_desc,"Fires a powerful musical attack, casts another spell upon collision","Стреляет мощной музыкальной атакой, при столкновении вызывает другое заклинание",,,,,,,射出一股强力的音乐攻击，并在碰撞时施放另一法术,音楽のパワーで攻撃する。着弾時に後ろの魔法を発動する。,,,,
spell_apotheosis_reverberation_name,Reverberation,Реверберация,,,,,,,回荡之声,エコー,,,,
spell_apotheosis_reverberation_desc,"Creates a reverberating sound in the air, slicing anything nearby to pieces.","Создаёт отзвук в воздухе, разрывая на куски всё, что находится поблизости.",,,,,,,一阵在空中回荡的魔声，切碎附近的一切,激しく反響する音を鳴らす。周囲のすべてを切断する力を持つ。,,,,
spell_apotheosis_bite_name,Bite,Укус,,,,,,,啃咬,かみつき,,,,
spell_apotheosis_bite_desc,...Magic?,...Волшебство?,,,,,,,...这是魔法？,魔法とは？,,,,
spell_apotheosis_bungal_shift_hyper_name,Hyper Fungal Shift,Супергрибковое смещение,,,,,,,超级真菌转换,スーパーきのこシフト,,,,
spell_apotheosis_bungal_shift_hyper_desc,Insane....,Безумие....,,,,,,,疯狂....,やばい。,,,,
spell_apotheosis_summon_worm_name,Summon Jättimato,Призыв яттимато,,,,,,,召唤巨型蠕虫,ヤッティマト召喚,,,,
spell_apotheosis_summon_worm_desc,Dangerous....,Опасно....,,,,,,,真危险....,あぶない,,,,
spell_apotheosis_bite_crit_name,Bloody Bite,Кровавый укус,,,,,,,血腥啃咬,ブラッディーかみつき,,,,
spell_apotheosis_bite_crit_desc,Magic...............................?,Волшебство...............................?,,,,,,,这是......魔法.........................?,魔法とは？？？？,,,,
spell_apotheosis_spells_to_sorako_name,Spells to Cats,Превращение в кошек,,,,,,,法术变猫咪,呪文からネコへ,,,,
spell_apotheosis_spells_to_sorako_desc,Transforms every projectile currently in the air into Cats; a cute idea,"Превращает каждый снаряд, находящийся в воздухе, в кошку. Милая идея",,,,,,,将附近自己施放的投射物转化为猫咪; 这主意有点可爱,周囲の放射物をネコに変換する。かしこい！,,,,
spell_apotheosis_split_shot_name,Split Shot,Разделяющийся выстрел,,,,,,,分裂一击,分裂ショット,,,,
spell_apotheosis_split_shot_desc,50% chance to duplicate the next cast,50% шанс на удвоение при следующем заклинании,,,,,,,50%概率复制此后的施放,次に詠唱される魔法が50％の確率で複製される。,,,,
spell_apotheosis_status_drunk_name,Mass Drunk,Массовое пьянство,,,,,,,群体醉酒,ほろ酔いフィールド,,,,
spell_apotheosis_status_drunk_desc,Affects every creature in a large radius with a drunken curse,Проклятие пьянства действует на каждое существо в большом радиусе,,,,,,,用醉酒诅咒影响大范围内的所有生物,周囲のすべての生物が特殊な酔っ払い状態になる。,,,,
spell_apotheosis_status_wet_name,Mass Wet,Массовая влага,,,,,,,群体濡湿,ずぶ濡れフィールド,,,,
spell_apotheosis_status_wet_desc,Soaks every creature in a large radius with a magical wetness,Пропитывает волшебной влагой всех существ в большом радиусе,,,,,,,用潮湿魔法浸透大范围内的所有生物,周囲のすべての生物が特殊な水濡れ状態になる。,,,,
spell_apotheosis_status_fire_name,Mass Fire,Массовый огонь,,,,,,,群体着火,炎上フィールド,,,,
spell_apotheosis_status_fire_desc,Burns every creature in a large radius with a magical fire,Сжигает волшебным огнём всех существ в большом радиусе,,,,,,,用魔法火焰灼烧大范围内的所有生物,周囲のすべての生物が特殊な炎上状態になる。,,,,
spell_apotheosis_status_urine_name,Mass Jarate,Массовое Банкате,,,,,,,群体瓶手道,尿フィールド,,,,
spell_apotheosis_status_urine_desc,Douses every creature in a large radius with a magical jarate.,Обливает всех существ в большом радиусе волшебным Банкате,,,,,,,用魔法尿瓶浇灌大范围内的所有生物,周囲のすべての生物が特殊な尿濡れ状態になる。,,,,
spell_apotheosis_status_polymorph_name,Mass Polymorph,Массовый полиморфизм,,,,,,,群体变形,変身フィールド,,,,
spell_apotheosis_status_polymorph_desc,Afflicts every creature in a large radius with a magical polymorphine,Поражает всех существ в большом радиусе волшебным полиморфизмом,,,,,,,用变形魔法影响大范围内的所有生物,周囲のすべての生物が変身する。,,,,
setting_apotheosis_catimmortality_name,Cat immortality,Бессмертие кошек,,,,,,,猫咪不会死亡,ネコの当たり判定無効化,,,,
setting_apotheosis_catimmortality_desc,Are cats immortal?,Являются ли кошки бессмертными?,,,,,,,猫咪是否不会死亡？,オンにすると、ネコが無敵になります。,,,,
setting_apotheosis_fairyimmortality_name,Fairy immortality,Бессмертие фей,,,,,,,精灵不会死亡,妖精の当たり判定無効化,,,,
setting_apotheosis_fairyimmortality_desc,Are Keiju immortal?,Являются ли Кейдзю бессмертными?,,,,,,,精灵是否不会死亡？,オンにすると、妖精が無敵になります。,,,,
setting_apotheosis_motd_name,Message of the Day,Сообщение дня,,,,,,,每日消息,今日のひとこと,,,,
setting_apotheosis_motd_desc,Will a MOTD be displayed at the start of each run? \nMay contain bonus hints for various secrets.,Будет ли сообщение дня отображаться в начале каждого забега? \nМожет содержать бонусные подсказки с различными секретами.,,,,,,,每局游戏开始前是否显示每日信息？\n其中可能向你提示各种秘密。,オンにすると、スタート地点に今日のひとことが書かれた看板が配置されます。\n隠し要素のヒントが書いてあることも？,,,,
setting_apotheosis_seasonal_name,Seasonal Events,Сезонные события,,,,,,,节日事件,季節イベント,,,,
setting_apotheosis_seasonal_desc,"Are seasonal events enabled? \nFor example, Halloween, More Creep's Birthday, etc.","Включены ли сезонные события? \nНапример, Хэллоуин, день рождения мода More Creep и т.д.",,,,,,,是否启用节日事件？\n例如万圣节，更多恐怖（译者注：本模组前身）的生日，等等,季節イベントを有効にしますか？\nハロウィンやMODのリリース記念日など、追加イベントがたくさん！,,,,
setting_apotheosis_bosshealthmultiplier_name,Boss Health Multiplier,Множитель здоровья босса,,,,,,,Boss 血量倍数,ボスのHP増加,,,,
setting_apotheosis_bosshealthmultiplier_desc,"Multiply all Bosses health by this much. \nFor those who seek extra durable opponents. \nDoes not affect Kolmisilma \nMinibosses will also have their health boosted by a partial amount. \nThis can be changed mid-run but may not update for all bosses, remember to restart after updating the multiplier.\n \nFor Modders: \nIf your mod isn't listed in the compatibility section of the mod page, \nthis likely won't boost it, you'll need to add a lua component to your bosses. \nDo not hesitate to contact me for instructions or help if needed. \nIt would be easiest for me to respond to you on discord, Conga Lyne#2452","Умножает здоровье всех боссов на это количество. \nДля тех, кто ищет особо стойких противников. \nНе влияет на Колмисильмяна \nМини-боссы также будут иметь частичное увеличение здоровья. \nЭто можно изменить в середине игры, но не для всех боссов, не забудьте перезапустить игру после обновления множителя.\n \nДля создателей модов: \nЕсли ваш мод не указан в разделе совместимости на странице модов, \nэто скорее всего не поможет, вам придётся добавить lua компонент к вашим боссам. \nНе стесняйтесь обращаться ко мне за инструкциями или помощью, если это необходимо. \nМне будет проще всего ответить вам в discord, Conga Lyne#2452.",,,,,,,将所有 Boss 的血量乘以此值。\n适合那些需要 Boss 更耐打的玩家。\n不影响三眼的血量。\n小 Boss 的血量也会得到部分提升。\n这个选项可以在游戏中途更改，\n但不一定会更新所有 Boss 的血量，\n记得在更改后重启游戏。\n \n写给模组开发者：\n如果你的模组没有被列在本模组的兼容性部分中，\n那么这个选项很可能不可用，你需要为你的 Boss 添加一个lua组件。\n如果需要指导或帮助，请随时联系我。\n我可以在 Discord 上回复你，这样最方便，Conga Lyne#2452,ボスのHPに倍率補正をかける上級者向けの設定です。\nコルミシルマには効果がありません。\nまた、ピットボスなどの中ボスにも一定程度効果が適用されます。\nプレイ中に設定を変更することも可能ですが、変更時はゲームを再起動してください。\nなお、ワークショップの対応MOD欄に記載されていないMODのボスには効果が適用されません。\nMOD製作者の方へ:適用させるためには専用のスクリプトが必要です。\n詳しくはDiscordでConga Lyne#2452にDMしてください。,,,,
setting_apotheosis_compatmode_conjurer_name,Conjurer extra Compatibility mode,Режим совместимости: Conjurer,,,,,,,Conjurer模组额外兼容模式,Conjurer連携,,,,
setting_apotheosis_compatmode_conjurer_desc,"Some people may have issues with this mod not loading into Conjurer properly. \nIf this happens, try enabling this option and loading conjurer again. \n \nThis option is on by default but can be turned off if you wish to \nhave the pixel scenes & bosses appear in conjurer worlds. \n \nIf Conjurer still fails to load despite having this turned on, although unlikely, \nit may be a mod compatibility issue with something else, \nperhaps try disabling mods to find the troublesome one. \n \nIf nothing else works please let me know to by filing a bug report to me. \nIt would be easiest for me to reach & investigate your report at the discord link below: \nhttps://discord.gg/gtyGnv8Pxk","У некоторых людей могут возникнуть проблемы с тем, что этот мод не загружается вместе с модом Conjurer должным образом. \nЕсли это произошло, попробуйте включить этот параметр и загрузить Conjurer снова. \n \nЭта опция включена по умолчанию, но может быть выключена, если вы хотите, чтобы пиксельные сцены и боссы появлялись в мирах Conjurer. \n \nЕсли Conjurer всё ещё не загружается, несмотря на включение этого параметра, хотя это маловероятно, \nможет быть проблема совместимости мода с чем-то другим, \nвозможно, попробуйте отключить все моды поочерёдно, чтобы найти проблемный. \nЕсли ничего не помогает, пожалуйста, сообщите мне об этом, написав сообщение об ошибке. \nМне будет проще всего связаться и изучить ваше сообщение по ссылке на discord: \nhttps://discord.gg/gtyGnv8Pxk",,,,,,,如果遇到启用此模组无法正常加载Conjurer模组的情况，\n请尝试启用此选项并重新加载 Conjurer模组。\n \n此选项默认打开，但如果您希望此模组的场景和Boss\n出现在Conjurer世界中，则需要关闭此选项。\n \n如果在打开此选项后仍然无法加载Conjurer模组，\n虽然可能性不大，但可能是其他模组的兼容性问题，\n你可以尝试依次禁用其它模组来找出有问题的模组。\n \n如果没有办法解决，请向我提交错误报告。\n可以通过下面的Discord链接与我取得联系并提交您的报告：\nhttps://discord.gg/gtyGnv8Pxk,Conjurerと同時導入時に発生する不具合が報告されています。\n不具合が発生する場合は、この設定をオンにした上でConjurerを再読み込みしてください。\n \nこの設定は初期状態でオンになっていますが、\nピクセルシーン、ボスなどの要素をConjurer環境でも楽しみたい場合はオフにしてください。\n \nこの設定をオンにしても不具合が直らない場合は、別の原因が考えられます。\nその場合は、MOD一覧から原因となっているMODを無効にしてください。\n \nそれでも回復しない場合は、こちらまで連絡してください。→https://discord.gg/gtyGnv8Pxk,,,,
setting_apotheosis_compatmode_spell_evolution_name,Spell Evolution Compatibility Mode,Режим совместимости: Spell Evolution,,,,,,,Spell Evolution模组额外兼容模式,Spell Evolution連携,,,,
setting_apotheosis_compatmode_spell_evolution_desc,"Turn this setting on if you're playing with the Spell Evolution mod to fix it.\n \nAs far as I can tell, a bug in Spell Evolutions causes it to break if a modded spell \n Uses translation keys for their name and/or description. \n \nUnfortunately there's nothing I can do about this as it's not my mod, \nand I have no intention to remove the translation keys \nas I hope to use them one day in the event \nI'm offered a translation for the mod to another language. \nHowever, I can put a setting in to optionally let you use the spells without \ntranslation keys to get around the issue.","Включите этот параметр, если вы играете с модом Spell Evolution, чтобы исправить ошибки.\n \nНасколько я могу судить, ошибка в Spell Evolutions приводит к тому, что он ломается, если модифицированное заклинание \n использует ключи перевода для своего имени и/или описания. \n \nК сожалению, я ничего не могу с этим поделать, поскольку это не мой мод, \n и у меня нет намерения удалять ключи перевода, \n поскольку я надеюсь использовать их однажды в случае, если мне предложат перевести мод на другие языки. \Однако, я могу сделать настройку, которая позволит вам использовать заклинания без ключей перевода, чтобы обойти эту проблему.",,,,,,,如果你将此模组与Spell Evolution模组同时启用，请开启此选项进行修复。\n \n据我所知，由于Spell Evolutions模组的一个漏洞，模组法术的名字或描述使用翻译关键字会导致游戏崩溃。\n \n遗憾的是，它不是我的模组，我对此无能为力。\n并且我不打算移除翻译关键字，因为我希望有一天能用到它们。\n我提供了一个翻译文档让这个模组能被翻译成另一种语言。\n作为妥协，我设置这个选项，让你在不使用翻译关键字的情况下使用法术，以解决这个问题。,このMODはSpell Evolutionのスペル強化機能に対応しています。\n \nただし、Spell Evolutionには翻訳キーを用いる魔法を強化した際に\n呪文の名前、説明文がおかしくなる不具合が存在します。\n \nこれに関しては作者の側では対応できませんでした。\nかといって、せっかく作って頂いた翻訳キーを消してしまう訳にもいきません。\n \nこの設定は、該当する翻訳キーを用いないようにすることで、\nSpell Evolution側の不具合を回避するためのものです。,,,,
status_apotheosis_duckcurse_name,Duck Curse,Утиное проклятие,,,,,,,鸭子诅咒,アヒルの呪い,,,,
status_apotheosis_duckcurse_desc,Their Quacky visions haunt you,Их утиные взгляды преследуют вас,,,,,,,它们嘎嘎叫的样子缠上了你,アヒルの幻影があなたを襲う！,,,,
status_apotheosis_manadrain_name,Mana Degradation,Разложение маны,,,,,,,法力退失,マナドレイン,,,,
status_apotheosis_manadrain_desc,You are losing Mana Rapidly!!,Вы стремительно теряете ману!!!,,,,,,,你的魔杖快速地失去法力！,マナが吸い尽くされていく！,,,,
status_apotheosis_transmute_name,Unstable Transmutation,Нестабильная трансмутация,,,,,,,不稳物质转换,不安定物質変換,,,,
status_apotheosis_transmute_desc,Your being is transmuting nearby matter uncontrollably!,Ваша сущность бесконтрольно превращается близлежащую материю!,,,,,,,你的存在无法控制地转化附近的物质！,周囲の物質が姿を変えていく！,,,,
1.1.0 content below,#ERROR!,,,,,,,,,,,,,
item_apotheosis_essence_fungus_name,Essence of Fungus,Эссенция грибка,,,,,,,真菌之精粹,キノコのエッセンス,,,,
item_apotheosis_essence_fungus_desc,Your very being is infecting the environment around it!,Сама ваша сущность заражает окружающую среду!,,,,,,,你的存在不断地感染周围的环境！,周囲の環境が姿を変えていく！,,,,
sign_apotheosis_welcome_hint,"Hello and Welcome to Apotheosis! \nAlthough this may seem inconvenient, please take a moment to view the mod settings page in Options > Mod Settings. \nSome mods need compatibility modes enabled, I did I my best but some things are outside my control sadly. Other than that, go nuts and have fun <3","Здравствуйте и добро пожаловать в мод Apotheosis \nХотя это может показаться неубедительным, пожалуйста, уделите время просмотру страницы настроек мода в «Параметры» > «Модификации». \nНекоторые моды требуют включения модов совместимости, я сделал всё возможное, но некоторые вещи, к сожалению, находятся вне моего контроля. В остальном, не сомневайтесь и получайте удовольствие <3",,,,,,,嗨，欢迎游玩 Apotheosis 模组！\n虽然听起来有些麻烦，但请花点时间查看选项->模组设置页面。\n有些模组需要启用兼容模式。我已经尽我所能进行适配了，但很遗憾\n有些东西不是我所能控制的。比起这种事，还请尽情游玩吧 <3,Apotheosis MODへようこそ！\nプレイする前に、まずMOD設定を確認してください。\n他MODとの連携要素は、設定から有効化しないと使えない場合があります。,,,,
sign_apotheosis_aprilfools_intro,Happy April Fools <3,Счастливого дня смеха <3,,,,,,,愚人节快乐 <3,エイプリルフール！,,,,
status_apotheosis_trip_red_00_name,Blazed,Ломка,,,,,,,发烧,酩酊,,,,
status_apotheosis_trip_red_00_desc,You feel dizzy.,Вы чувствуете головокружение.,,,,,,,你感到头晕。,頭がフワフワしてきた。,,,,
status_apotheosis_trip_red_01_name,Somewhat Blazed,Небольшая ломка,,,,,,,发热,ちょっとトリップ,,,,
status_apotheosis_trip_red_01_desc,You feel interlinked with Yggdrasil.,Вы чувствуете связь с Иггдрасилем.,,,,,,,你感觉自己和世界树相连接。,ユグドラシルとの繋がりを感じる。,,,,
status_apotheosis_trip_red_02_name,Really Blazed,Сильная ломка,,,,,,,严重发热,スーパートリップ,,,,
status_apotheosis_trip_red_02_desc,You feel a pleasant burning sensation build up inside you.,"Вы чувствуете, как внутри вас нарастает приятное жжение.",,,,,,,你感到一股美妙的燃烧感在体内积累。,身体の中が熱く燃え盛るように感じる。,,,,
status_apotheosis_trip_red_03_name,Blazed as Hell,Чертовски сильная ломка,,,,,,,极度发热,ハイパートリップ,,,,
status_apotheosis_trip_red_03_desc,Usual concepts don't apply.,Обычные понятия неприменимы.,,,,,,,通常的概念已经不再适用。,宇宙の法則が乱れる！,,,,
item_apotheosis_fungus_stone_name,Sienenkivi,Сененкиви,,,,,,,真菌石,シエネンキヴィ,,,,
item_apotheosis_fungus_stone_desc,You feel the world transforming in the palm of your hand.,"Вы чувствуете, как мир преображается у вас на ладони.",,,,,,,你感觉世界在你的手中变换。,腕の中で世界が作り替えられていくような感覚がする。,,,,
item_apotheosis_chest_portals,Dimensional Chest,Пространственный сундук,,,,,,,维度宝箱,高次元チェスト,,,,
item_apotheosis_chest_volcanic,Volcanic Chest,Вулканический сундук,,,,,,,火山宝箱,火山のチェスト,,,,
status_apotheosis_haste_name,Haste,Спешка,,,,,,,急速,電光石火,,,,
status_apotheosis_haste_desc,You feel faster,Вы чувствуете себя быстрее,,,,,,,你感觉变快了,スピードが上がっている。,,,,
material_apotheosis_meat_mana,Enchanting Meat,Очаровательное мясо,,,,,,,带有魔力的肉,魔法の肉,,,,
material_apotheosis_smoke_static_slowburn_name,Dense Smoke,Плотный дым,,,,,,,浓烟,厚い煙,,,,
material_apotheosis_meat_fire_lukki,Infernal Meat,Адское мясо,,,,,,,地狱的肉,地獄の肉,,,,
material_apotheosis_meat_fire_lukki_rock,Brimstone,Сера,,,,,,,硫磺,硫黄,,,,
material_apotheosis_mudman_mud,Magical Mud,Волшебный ил,,,,,,,魔法淤泥,魔法の泥,,,,
material_apotheosis_knowledge_of_kings,Yggdrasil's Knowledge,Знания Иггдрасиля,,,,,,,世界树的圣理,ユグドラシルの智慧,,,,
spell_apotheosis_targetter_name,Targetter,Целеуказатель,,,,,,,众矢之的,ロックオン,,,,
spell_apotheosis_targetter_desc,Fire a projectile which causes irresistible hatred towards anything it hits,"Выпускает снаряд, который вызывает непреодолимую ненависть ко всему, во что попадает",,,,,,,将万千仇恨施加于目标的法术,この放射物に当たった敵は、周囲の生物全てから敵対される。,,,,
spell_apotheosis_firecharge_name,Fire Charge,Огненный заряд,,,,,,,火焰放射,ファイアーチャージ,,,,
spell_apotheosis_firecharge_desc,"Imbues a projectile with a fiery charge, that it will release on impact","Наделяет снаряд огненным зарядом, который он выпустит при ударе",,,,,,,令投射物在击中时散发火焰放射,炎の力を放射物に込める。着弾すると力が解放される。,,,,
spell_apotheosis_knowledge_of_kings_name,The Knowledge of Kings,Знание королей,,,,,,,王者的真理,王たちの智慧,,,,
spell_apotheosis_knowledge_of_kings_desc,Casting this spell causes something irreversibly permanent to occur,Использовании этого заклинания происходит нечто необратимо постоянное,,,,,,,施放这个法术会导致一些永远无法逆转的事情发生,非可逆的な何かが起きる。,,,,
spell_apotheosis_portal_lukki_red_portal_name,Summon Red Portal,Призыв красного портала,,,,,,,召唤红色传送门,赤いポータルの召喚,,,,
spell_apotheosis_portal_lukki_red_portal_desc,"Summons a red tinted portal to where it is focused, Right Click to mark a location for the portal to focus on.","Призыв портала с красным оттенком. Щёлкните правой кнопкой мыши, чтобы отметить место, на котором будет сфокусирован портал.",,,,,,,召唤一个红色的传送门，通向焦点处。右键单击设置传送门焦点位置。,指定した地点へと続くポータルを召喚する。右クリックで行き先を指定できる。,,,,
spell_apotheosis_portal_lukki_blue_portal_name,Summon Blue Portal,Призыв синего портала,,,,,,,召唤蓝色传送门,青いポータルの召喚,,,,
spell_apotheosis_portal_lukki_blue_portal_desc,"Summons a blue tinted portal to where it is focused, Right Click to mark a location for the portal to focus on.","Призыв портала с синим оттенком. Щёлкните правой кнопкой мыши, чтобы отметить место, на котором будет сфокусирован портал.",,,,,,,召唤一个蓝色的传送门，通向焦点处。右键单击设置传送门焦点位置。,指定した地点へと続くポータルを召喚する。右クリックで行き先を指定できる。,,,,
spell_apotheosis_portal_lukki_green_portal_name,Summon Green Portal,Призыв зелёного портала,,,,,,,召唤绿色传送门,緑色のポータルの召喚,,,,
spell_apotheosis_portal_lukki_green_portal_desc,"Summons a green tinted portal to where it is focused, Right Click to mark a location for the portal to focus on.","Призыв портала с зелёным оттенком. Щёлкните правой кнопкой мыши, чтобы отметить место, на котором будет сфокусирован портал.",,,,,,,召唤一个绿色的传送门，通向焦点处。右键单击设置传送门焦点位置。,指定した地点へと続くポータルを召喚する。右クリックで行き先を指定できる。,,,,
spell_apotheosis_alt_fire_teleport_name,Alt Fire Teleport Bolt,Телепортирующая молния (ПКМ),,,,,,,副法术 - 传送魔弹,テレポートボルト(ALT),,,,
spell_apotheosis_alt_fire_teleport_desc,Right Click to fire a magical bolt that moves you wherever it ends up flying,"Щёлкните правой кнопкой мыши, чтобы запустить телепортационную молнию.",,,,,,,(右键施放)将你传送到其结束飞行位置的魔法弹,右クリックすると、テレポートボルトが発射される。,,,,
spell_apotheosis_alt_fire_teleport_short_name,Alt Fire Small Teleport Bolt,Малая телепортирующая молния (ПКМ),,,,,,,副法术 - 小传送魔弹,小型テレポートボルト(ALT),,,,
spell_apotheosis_alt_fire_teleport_short_desc,Right Click to fire a shortlived magical bolt that moves you wherever it ends up flying,"Щёлкните правой кнопкой мыши, чтобы запустить малую телепортационную молнию.",,,,,,,(右键施放)将你传送到其结束飞行位置的短时存在魔法弹,右クリックすると、小型テレポートボルトが発射される。,,,,
misc_apotheosis_energy_nova,Energy Nova,Энергия Новы,,,,,,,能量新星,エナジーノヴァ,,,,
log_apotheosis_moon_altar_fungus,AN IRREVERSIBLE CORRUPTION HAS OCCURRED,ПРОИЗОШЛА НЕОБРАТИМАЯ ПОРЧА,,,,,,,不可逆转的腐化发生了,すさまじい汚染が発生している！,,,,
logdesc_apotheosis_moon_altar_fungus,WHAT HAVE YOU DONE!?,ЧТО ВЫ НАДЕЛАЛИ!?,,,,,,,你做了什么！?,何が起こったんだ！？,,,,
log_apotheosis_toxicnest_secret_name,I TOLD YOU NOT TO VISIT THE WORM NEST AT 3AM,Я ЖЕ ГОВОРИЛ ВАМ НЕ ПОСЕЩАТЬ ГНЕЗДО ЧЕРВЕЙ В 3 ЧАСА НОЧИ,,,,,,,我告诉过你不要在凌晨 3 点进入剧毒蠕虫巢穴,どうして夜中に毒虫の巣に入ったんですか？？？？？,,,,
status_apotheosis_protection_lava_name,Lava Immunity,Стойкость к лаве,,,,,,,岩浆免疫,溶岩免疫,,,,
status_apotheosis_protection_lava_desc,You take no direct damage from lava or fire.,Вы не получаете прямого урона от лавы или огня.,,,,,,,你不会受到来自岩浆或火焰的直接伤害。,溶岩と炎によるダメージが無効化される。,,,,
status_apotheosis_explosive_orb_name,Explosive,Взрывчатка,,,,,,,爆炸物,爆発,,,,
status_apotheosis_explosive_orb_desc,You're transmuting magic into explosives!,Вы превращаете магию во взрывчатку!,,,,,,,你将魔法转化为爆炸物！,魔法が爆発に変わっている！,,,,
creep_apotheosis_boss_fire_lukki_name,Tulen Esteetikko,,,,,,,,火之美学家,ラーモン・エステーティッコ,,,,
creep_apotheosis_boss_water_lukki_name,Vesi Esteetikko,,,,,,,,水之美学家,ウォーター・エステティシャン,,,,
integration_apotheosis_RANDOM_CATS_name,Kitty Cats!!,Кошечки!!!,,,,,,,小猫咪！！,ねこ！,,,,
integration_apotheosis_RANDOM_CATS_desc,Cat! I'm a kitty cat! And I dance dance dance! And I dance dance dance!!,Кошка!! Я кошечка!! И я танцую туц-туц!! И я танцую танцую танцую танцую!!!,,,,,,,猫咪！我是一只小猫咪！我跳跳跳跳跳舞！手舞足蹈！,ねこです。ねこはいます。,,,,
integration_apotheosis_RANDOM_CREEPS_name,Random Creeps & Weirdos,Случайные твари и чудики,,,,,,,随机怪物,ランダム生物召喚,,,,
integration_apotheosis_RANDOM_CREEPS_desc,Random Creeps & Weirdos will appear in 5 seconds.,Случайные твари и чудики появятся через 5 секунд.,,,,,,,随机的怪物将在 5 秒后出现。,5秒後にランダムな生物が出現する。,,,,
integration_apotheosis_WAND_WONDERS_name,Spawn Wand of Wonders,Создать Жезл чудес,,,,,,,生成妙想之杖,フシギな杖の召喚,,,,
integration_apotheosis_WAND_WONDERS_desc,A wonderful wand capable of anything. Cast it!,"Чудесный жезл, способный на всё. Колдуйте!!",,,,,,,一个包含一切的奇妙魔杖，施法吧！,最強の杖を召喚する。撃ってみよう！,,,,
integration_apotheosis_PANDORA_CHEST_name,Pandora's Chest,Сундук Пандоры,,,,,,,潘多拉的箱子,パンドラの箱,,,,
integration_apotheosis_PANDORA_CHEST_desc,Do you dare open?,Осмелитесь ли вы открыть?,,,,,,,你敢打开吗？,本当に開けてしまうのか？,,,,
integration_apotheosis_RANDOM_CREEPS_BOSS_name,Random Weirdo Boss,Случайный босс-чудик,,,,,,,随机怪异 Boss,ランダムボス召喚,,,,
integration_apotheosis_RANDOM_CREEPS_BOSS_desc,A random Apotheosis boss will appear after 10 seconds.,Через 10 секунд появится случайный босс мода Apotheosis.,,,,,,,一个随机的 Apotheosis 专属 Boss 将在 10 秒后出现。,ランダムなボスが10秒後に出現する。,,,,
integration_apotheosis_STONE_FUNGUS_name,Sienenkivi,Сененкиви,,,,,,,真菌石,シエネンキヴィ,,,,
integration_apotheosis_STONE_FUNGUS_desc,Fungus Stone,Грибковый камень,,,,,,,真菌的石头,きのこストーン,,,,
integration_apotheosis_CREATURE_SHIFT_name,Creature Shift,Сдвиг существ,,,,,,,生物转换,生物シフト,,,,
integration_apotheosis_CREATURE_SHIFT_desc,Causes a creature to randomly be shifted with another.,Вызывает случайное смещение одного существа с другим.,,,,,,,让一个生物随机转换成另一个生物,生物が別のものに姿を変える。,,,,
integration_apotheosis_TRANSFORM_WORMS_name,Spells to Worms,Превращение в червяков,,,,,,,法术变蠕虫,呪文からワームへ,,,,
integration_apotheosis_TRANSFORM_WORMS_desc,All projectiles currently in the air turn into worms!,"Все снаряды, находящиеся в воздухе, превращаются в червей!!",,,,,,,当前空中所有的投射物变成蠕虫！,すべての放射物がワームに変化する。,,,,
integration_apotheosis_MUD_MEN_name,Summon Mud Men,Призыв грязевика,,,,,,,召唤泥人,マッドマン召喚,,,,
integration_apotheosis_MUD_MEN_desc,MUD MEN are here to save the day!!,"ГРЯЗЕВИК пришёл, чтобы помочь вам!!!",,,,,,,泥人们来拯救世界了！！,情け無用の男、マッドマン！,,,,
integration_apotheosis_HUNGRY_ORB_name,Hungry Orb,Голодный шар,,,,,,,饥饿法球,はらぺこオーブ,,,,
integration_apotheosis_HUNGRY_ORB_desc,???,???,,,,,,,？？？,これ is なに？,,,,
integration_apotheosis_DELUSIONAL_name,Delusional Streamer,Стример-шизик,,,,,,,妄想症主播,まぼろしストリーマー,,,,
integration_apotheosis_DELUSIONAL_desc,Your senses deceive you.,Ваши чувства обманывают вас.,,,,,,,你的感官欺骗了你。,幻覚が見えるようになる。,,,,
integration_apotheosis_CLOWNS_name,CLOWNS,КЛОУНЫ,,,,,,,小丑,からくりピエロ,,,,
integration_apotheosis_CLOWNS_desc,"You're not a clown, you're the entire circus!!","Вы не клоун, вы целый цирк!!!",,,,,,,你才不是什么小丑，你根本就是一整个马戏团！！,俺自身がサーカスになることだ,,,,
integration_apotheosis_SWAPPER_CURSE_name,Curse of Swapping,Проклятие подмены,,,,,,,换位诅咒,スワッパーの呪い,,,,
integration_apotheosis_SWAPPER_CURSE_desc,You feel the blood of Swapper Mages runs through you,"Вы чувствуете, как в вас течёт кровь магов-подменщиков.",,,,,,,你感觉自己身上流淌着换位法师的血液。,スワップ魔術師の血が体内を駆け巡る。,,,,
secretmessage_apotheosis_herobrine_01,I see you.,Я тебя вижу.,,,,,,,我看见你了。,ミ テ イ ル ゾ,,,,
secretmessage_apotheosis_divineorb_name,You discovered an orb of divine knowledge,Вы обнаружили шар божественных знаний,,,,,,,你发现了一个神圣知识的球体,神聖な智慧のオーブを発見した,,,,
secretmessage_apotheosis_divineorb_desc,Secrets of otherworldly royalty have been unlocked to you.,Вам стали открыты секреты потусторонней королевской власти.,,,,,,,超凡脱俗的皇家秘密已然向你开放。,異界の力が解き放たれた。,,,,
secretmessage_apotheosis_kingly_alreadydone,You feel the secrets of otherworldly royalty have already been unleashed...,"Вы чувствуете, что секреты потусторонней королевской власти уже раскрыты...",,,,,,,你感觉到超凡脱俗的皇家秘密已经解开过了...,異界の力はすでに解き放たれている。,,,,
secretmessage_apotheosis_kingly_cheater,You feel the magic is incomplete...,"Вы чувствуете, что волшебство не завершено...",,,,,,,你感觉魔法还不完整...,この力はまだ完成されていない？,,,,
secretmessage_apotheosis_capeget_name,You feel more.. pretty..?,Вы чувствуете себя более.. симпатичными..?,,,,,,,你感觉自己更加..美丽..？,なんだか自分が……可愛くなった？。,,,,
secretmessage_apotheosis_capeget_desc,Truly befitting.,Очень удовлетворительно.,,,,,,,它的确非常适合你。,とても似合っている気がする。,,,,
secretmessage_apotheosis_divineorb_heart_name,You found a familiar orb of divine knowledge,Вы нашли знакомый шар божественных знаний,,,,,,,你发现了一个熟悉的神圣知识球体,神聖な智慧のオーブを拾った,,,,
book_apotheosis_symbol_centipede_blood,Tuhatjalkainen Veri,Тухатьялкайнен Вери,,,,,,,蜈蚣之血,,,,,
book_apotheosis_symbol_centipede_blood_description,"Half a circle, and a spine connected to it. \nThree legs on each side, and the centipede's inner liquid is born.","Половина круга, и к нему присоединяется позвоночник. \nТри ноги с каждой стороны, и рождается внутренняя жидкость сороконожки.",,,,,,,半圆和脊柱相连。\n每侧 3 条腿，蜈蚣内部的液体就诞生了。,,,,,
book_apotheosis_symbol_redsand,Punainen Hiekka,Пунайнен Хиекка,,,,,,,红砂,,,,,
book_apotheosis_symbol_redsand_description,"Three lines. One Horizonal, two more starting at the edges of the first line which converge upwards to touch each other at their ends. \nWithin this new shape, circles lay. \none. two. and three. \nThese three circles represent the specks of dust, and thus a blazing red powder is born.","Три линии. Одна горизонтальная, две другие, начинающиеся от краёв первой линии, которые сходятся вверх и касаются друг друга своими концами. \nВ этой новой форме лежат круги. \nОдин. два. и три. \nЭти три круга представляют собой пылинки, и таким образом рождается пылающий красный порошок.",,,,,,,三条线。一条水平，另外两条线始于第一条线的端点，向上延伸，相交处为终点。\n在这个新的形状中画几个圆。\n一、二、三\n这三个圆代表尘埃，于是炙热的红色粉末就此诞生了。,,,,,
book_apotheosis_symbol_insecthusk,Hyönteisten Kuori,Хьонтейстен Куори,,,,,,,虫壳,,,,,
book_apotheosis_symbol_insecthusk_description,"One triangle, and another below facing the other way. \nDraw a line to connect these two formations. \nStart from the center of the first, and draw down until it pierces through the second triangle. \nFrom this new symbol, the husk of insects is born.","Один треугольник, а другой внизу обращён в другую сторону. \nНарисуйте линию, соединяющую эти два образования. \nНачните с центра первого треугольника и проведите линию вниз, пока она не пронзит второй треугольник. \nИз этого нового символа рождается шелуха насекомых.",,,,,,,一个三角形，下面的另一个三角形朝向另一边。\n画一条线连接这两个三角形。\n从第一个三角形的中心开始向下画，直到它完全穿透第二个三角形。\n虫壳将从这个新符号诞生。,,,,,
book_apotheosis_symbol_divineliquid,Jumalallinen Neste,Джумалаллинен Несте,,,,,,,神圣液体,,,,,
book_apotheosis_symbol_divineliquid_description,"Place down your brush, and draw nothing less than a perfect circle. \n \nWithin this circle, draw the four elements. \nOne line for Fire \nOne for Water \nOne for Earth \nand One for Air. \n \nWhere the elements converge, make another perfect circle, fill it in with purpose. \nWith this, a divine drink is born.","Положите кисть и нарисуйте не менее чем идеальный круг. \n \nВ этом круге нарисуйте четыре элемента. \nОдна линия для огня \nОдна для воды \nОдна для земли \nи одна для воздуха. \nТам, где элементы сходятся, сделайте ещё один идеальный круг, заполните его. \nПосле этого рождается божественный напиток.",,,,,,,落下你的画笔，画一个完美的圆。 \n \n在这个圆上，画出四元素。\n一条线代表火\n一条线代表水\n一条线代表土\n一条线代表气。\n \n在元素汇聚之处，画另一个完美的圆，填满它。\n做完这些，一种神圣的饮品就诞生了。,,,,,
book_apotheosis_symbol_pinksand,Vaaleanpunainen Hiekka,Ваалеанпунайнен Хиекка,,,,,,,粉砂,,,,,
book_apotheosis_symbol_pinksand_description,"A triangle. Within this, create a line piercing through it's purpose. \nInside this triangle near it's peak, a circle sits. \nThe circle is pierced by the line, and is ready to change shape. \nWith this symbol, the pinkest sand will be born.","Треугольник. Внутри него проведите линию, пронизывающую его насквозь. \nВнутри этого треугольника, около его вершины, сидит круг. \nКруг пронзён линией и готов изменить форму. \nС этим символом родится самый розовый песок.",,,,,,,一个三角形。在三角形内，画出一条线穿透它。\n在这个三角形的内部，靠近顶点的地方，有一个圆。\n这个圆被线穿透，准备改变形状。\n有了这个符号，最粉的砂就诞生了。,,,,,
book_apotheosis_symbol_fungus,Sieni,Сиени,,,,,,,真菌,,,,,
book_apotheosis_symbol_fungus_description,"Two circles, these are specks of dust. \nBetween these specks, draw a line moving upwards. \nWhere the line stops draw two more moving towards the circles. \nConnect the ends of those lines together with one final line, and a fungal infection is born.","Два круга - это пылинки. \nМежду ними проведите линию, двигающуюся вверх. \nВ месте остановки линии нарисуйте ещё две, двигаясь по направлению к кругам. \nСоедините концы этих линий вместе последней линией, и таким образом родится грибковая инфекция.",,,,,,,两个圆，象征着尘埃。\n在这些尘埃中间画一条向上的线。\n在这条线停止的地方，再向圆的方向画两条线\n把这两条线的末端用线相连，这样一个真菌感染就诞生了。,,,,,
book_apotheosis_fire_lukki,Scorched Notes,Опалённые записки,,,,,,,烧焦的笔记,,,,,
book_apotheosis_fire_lukki_description,"I remember finding a stone, blazing with fire but nothing more than a gentle touch in my hand. \nIt belonged to those fire cretins who hunted me I bet. \n \nWanting to get back at them I threw the stone into the deepest body of lava I could find in those wretched mines.. \nBut that was my fatal mistake. \n \nThe stone seemed to attract... something. \nI dared not look back after hearing the lava stir violently behind me, I feel lucky to be alive. \n \nMy robes were scorched by it's mere presence. \nMy pride reduced to burn marks of what it once was. \nI hope I need never return to that place.","Я помню, как нашёл камень, пылающий огнём, но не более чем легкое прикосновение моей руки. \nНаверняка он принадлежал тем огненным кретинам, которые охотились на меня. \nЖелая отомстить им, я бросил камень в самую глубокую лаву, которую смог найти в этих жалких шахтах. \nНо это была моя роковая ошибка. \n \n Камень, казалось, притягивал... что-то. \nЯ не смел оглянуться, когда услышал, как за спиной яростно зашипела лава. Мне повезло, что я остался жив. \nМоя одежда опалилась от одного его присутствия. \nМоя гордость превратилась в ожоги от того, чем она когда-то была. Надеюсь, я никогда не вернусь в это место.",,,,,,,我记得我找到过一块石头，燃烧着熊熊烈火，但拿在手里却只能感到宜人的温暖。\n我敢打赌，它是那些追杀我的火焰鳖孙的。\n \n为了报复它们，我把石头扔进了那个晦气矿井旁的岩浆最深处。\n但这是我犯下的天大的错误。\n \n石头似乎吸引了......什么东西。\n听到身后岩浆剧烈翻滚的声音后，我头都不敢回的逃跑了，我为自己还活着感到庆幸。\n \n我的长袍被那个东西烧焦了，我的自尊心也被灼烧殆尽。\n我再也不想回到那个地方了。,,,,,
status_apotheosis_plagiarize_swapper_name,Curse of Swapping,Проклятие подмены,,,,,,,交换诅咒,スワッパーの呪い,,,,
status_apotheosis_plagiarize_swapper_desc,Taking damage makes you swap places with the attacker.,,,,,,,,受到伤害会使你与攻击者交换位置。,ダメージを受けると、攻撃してきた敵の位置にワープする。,,,,
status_apotheosis_delusional_name,Delusional,Галлюцинации,,,,,,,妄想,幻覚,,,,
status_apotheosis_delusional_desc,Your senses deceive you.,Ваши чувства обманывают вас.,,,,,,,你的感官在欺骗你。,自分の感覚がアテにならない。,,,,
status_apotheosis_creatureshift_cd_name,Unshiftable,Несдвигаемый,,,,,,,无法转换,きのこシフト無効化,,,,
status_apotheosis_creatureshift_cd_desc,The path of evolution is set in stone... For now.,Путь эволюции предначертан... Пока что.,,,,,,,生命的法则十分稳定...目前是这样。,進化の流れが足を止めた……今は。,,,,
perk_apotheosis_revenge_reflective,Revenge Reflection,Отражение мести,,,,,,,复仇反射,反射,,,,
perk_apotheosis_revenge_reflective_description,"Reflect copies of enemy projectiles upon taking damage, with a steep damage boost as payback.",Отражение копий вражеских снарядов при получении урона с резким увеличением урона в качестве расплаты.,,,,,,,被敌人的投射物击中时会以其复制品予以回击，并且复制品拥有极高的伤害加成。,敵の放射物を反射する。反射した放射物は威力が上がる。,,,,
biomemod_apotheosis_smoke_dense,The air feels unusually dense,Воздух кажется необычайно плотным,,,,,,,空气感觉异常地稠密,空気がとても重い。,,,,
credits_apotheosis_line_01,a mod made by,"мод, созданный",,,,,,,,,,,,
credits_apotheosis_line_04,Lead Developer of Apotheosis,Главный разработчик Apotheosis,,,,,,,,,,,,
credits_apotheosis_line_07,Voice Actor of the Cats,Актёр озвучивания кошек,,,,,,,,,,,,
credits_apotheosis_line_14,Creator of the Mana Drain Script,Создатель скрипта расхода маны,,,,,,,,,,,,
credits_apotheosis_line_17,Russian Translator,Перевод на русский,,,,,,,,,,,,
credits_apotheosis_line_ch_trans,Chinese Translators,,,,,,,,,,,,,
credits_apotheosis_line_20,"Helped with some creature design & mod direction, also helped with alt-fire spells.","Помогал с дизайном существ и направлением мода, также помогал с заклинаниями на ПКМ.",,,,,,,,,,,,
credits_apotheosis_line_22,Special Thanks to,Особая благодарность,,,,,,,,,,,,
credits_apotheosis_line_39,And many modders of the Noita Discord,И многим создателям модов из Discord-сервера Noita,,,,,,,,,,,,
credits_apotheosis_line_43,"And finally.. you, for giving Apotheosis a try and making it this far into the mod!","И наконец.. вам, за то, что попробовали Apotheosis и зашли так далеко в этом моде!",,,,,,,,,,,,
credits_apotheosis_line_44,I hope you enjoyed playing it as much as I enjoyed making it <3,"Надеюсь, вам понравилось играть в него так же, как мне понравилось его создавать <3",,,,,,,,,,,,
credits_apotheosis_line_45,Best of luck in your future adventures - Conga Lyne,Желаю удачи в ваших будущих приключениях - Conga Lyne,,,,,,,,,,,,
credits_apotheosis_line_horscht,Provided a ton of help in the mod support channel during development and let me use his credits script.,Оказал тонну помощи в канале поддержки мода во время разработки и позволил мне использовать его скрипт для этого меню.,,,,,,,,,,,,
Apotheosis content below,#ERROR!,,,,,,,,,,,,,
teleport_portal_alternate,Portal Elsewhere,,,,,,,,通向别处的传送门,彼方へのポータル,,,,
teleport_portal_moon,Portal to the Moon,,,,,,,,通向月球的传送门,月への扉,,,,
teleport_portal_sun,Portal to the Sun,,,,,,,,通向太阳的传送门,太陽への扉,,,,
teleport_portal_up,Portal Higher,,,,,,,,通向上一层的传送门,上層へのポータル,,,,
biome_slime_hell,Virulent Caverns,,,,,,,,毒性洞穴,猛毒洞窟,,,,
biome_slime_hell_outpost,Contaminated Outpost,,,,,,,,污染哨站,汚れた兵営,,,,
biome_toxic_worm_cave,Toxic Nest,,,,,,,,剧毒巢穴,毒虫の巣穴,,,,
biome_abandoned_assembly,Sandy Assembly,,,,,,,,沙地朝会,砂の遺跡,,,,
biome_esoteric_den,Abyssum,,,,,,,,深渊,アビス,,,,
biome_underground_forest,Subterrain Woodland,,,,,,,,地下林地,地底の森林,,,,
biome_evil_temple,Temple of Sacrilegious Remains,,,,,,,,亵渎骸骨神庙,冒涜的な祭壇の跡地,,,,
biome_desert_pit,Sinkhole,,,,,,,,落沙洞穴,砂漠の大穴,,,,
biome_lava_excavation,Core Mines,,,,,,,,核心矿场,地底鉱山,,,,
biome_abyssal_depths,Forgotten Depths,,,,,,,,遗忘深渊,忘れられた空間,,,,
biome_mueseum,Marble Halls,,,,,,,,大理石厅堂,大理石の大部屋,,,,
biome_ant_hell,Ant Nest,,,,,,,,蚁巢,アリの巣,,,,
biome_plane_yggdrasil,Plane of Yggdrasil,,,,,,,,世界树位面,世界樹の大地,,,,
biome_plane_yggdrasil_border,Outer Plane of Yggdrasil,,,,,,,,世界树外平台,世界樹の大地との境界,,,,
biome_plane_magic,Plane of Soul,,,,,,,,灵魂位面,魂の在処,,,,
biome_plane_technology,Plane of Experimentation,,,,,,,,实验位面,実験者の住処,,,,
biome_empyrean,Empyrean,,,,,,,,天界,天界,,,,
biome_challenge_zone,Sealed Library,,,,,,,,禁闭图书馆,閉ざされた書庫,,,,
biome_surface,The Surface,,,,,,,,地表,地上,,,,
biome_jungle_fleshy,The Red Jungle,,,,,,,,血红丛林,赤い密林,,,,
biomemod_esoteric_presence,You feel an indescribable aura...,,,,,,,,你感到一股难以形容的气场...,言葉に表せないような力を感じる,,,,
biomemod_magmatic,The air is burning,,,,,,,,空气炎热无比,空気が燃えるように熱い,,,,
biomemod_necromancy,The Dead are Restless,,,,,,,,死者永不安息,死霊が騒ぐ声が聞こえる,,,,
biomemod_esoteric_den,You feel the world has indescribable shapes...,,,,,,,,你感到世界的形态难以形容,眼前に奇妙な世界が広がる,,,,
biomemod_alchemic,You feel an alchemical mist in the air,,,,,,,,空气中有一层炼金术的薄雾,魔法の霧が辺りを覆っている,,,,
biomemod_plane_yggdrasil,"A dense jungle with endless life, filled with monsters foreign",,,,,,,,拥有无尽生命的茂密丛林，充斥着外来的怪物,深林には異界の生物が暮らしている,,,,
biomemod_plane_magic,"Your soul feels heavy, wild magic is in the air",,,,,,,,你的灵魂感受到沉重而疯狂的魔法气息,むき出しの魔力があなたの魂にのしかかる,,,,
biomemod_plane_mechanical,"A scorched wasteland, unfit for biological life",,,,,,,,一片焦土荒原，不适合生物生存,生命の息吹を感じられない,,,,
biomemod_slime_hell,You feel strangely warm,,,,,,,,你感到一种奇怪的温暖,奇妙な温もりを感じる,,,,
biomemod_heretical,You feel a malicious presence,,,,,,,,你感觉到这里有一个恶意的存在,,,,,
material_apotheosis_bloodystone,Bloody Stonework,,,,,,,,血腥石雕,血染めの石細工,,,,
material_apotheosis_sandystone,Sandy Stonework,,,,,,,,沙质石雕,砂質の石積み,,,,
material_apotheosis_corruptflesh,Vacillating Flesh,,,,,,,,摆动血肉,揺らぐ肉,,,,
material_apotheosis_blood_infectous,Infectious Blood,,,,,,,,感染的血,汚染された血,,,,
material_apotheosis_volcanicrock_static_dense,Dense Volcanic Rock,,,,,,,,致密火山岩,非常に硬い火山岩,,,,
material_apotheosis_volcanicrock_superhot,Burning Rock,,,,,,,,燃烧岩石,焼け石,,,,
material_apotheosis_cursed_liquid,Cursed Liquid,,,,,,,,诅咒液体,呪われた液体,,,,
material_apotheosis_magic_liquid_infinite_flight,Soarium,,,,,,,,翱翔魔药,飛行の魔薬,,,,
material_apotheosis_magic_liquid_infinite_flight_gas,Soarium Gas,,,,,,,,翱翔魔药气体,飛行のガス,,,,
material_apotheosis_magic_liquid_nukes,Nukium,,,,,,,,核变魔药,核爆弾の魔薬,,,,
material_apotheosis_magic_liquid_nukes_gas,Nukium Gas,,,,,,,,核变魔药,核爆弾のガス,,,,
material_apotheosis_magic_liquid_escapium,Escium,,,,,,,,逃生魔药,逃亡の魔薬,,,,
material_apotheosis_magic_liquid_escapium_gas,Escium Gas,,,,,,,,逃生魔药气体,逃亡のガス,,,,
material_apotheosis_magic_liquid_attunium,Attunium,,,,,,,,校准魔药,調律の魔薬,,,,
material_apotheosis_magic_liquid_attunium_gas,Attunium Gas,,,,,,,,校准魔药气体,調律のガス,,,,
material_apotheosis_magic_liquid_attunium_cloud,Attunium Mist,,,,,,,,校准魔药雾,調律の魔薬のミスト,,,,
material_apotheosis_magic_liquid_pure_light,Pure Light,,,,,,,,纯粹光芒,液化した光,,,,
material_apotheosis_magic_liquid_pure_light_cloud,Pure Light Mist,,,,,,,,纯粹光雾,液化した光のミスト,,,,
material_apotheosis_magic_liquid_suffocatium,Suffocatium,,,,,,,,窒息魔药,窒息の魔薬,,,,
material_apotheosis_magic_liquid_velocium,Veloium,,,,,,,,速度魔药,速度の魔薬,,,,
material_apotheosis_magic_liquid_velocium_gas,Veloium Gas,,,,,,,,速度魔药气体,速度のガス,,,,
material_apotheosis_magic_liquid_mimic,Mimicium,,,,,,,,拟态液,ミミックの魔薬,,,,
material_apotheosis_magic_liquid_rideshare,Portalium,,,,,,,,传送门魔药,ポータルの魔薬,,,,
material_apotheosis_magic_liquid_rideshare_gas,Portalium Gas,,,,,,,,传送门魔药气体,ポータルの魔薬,,,,
material_apotheosis_magic_liquid_moon_portal,Solunarium,,,,,,,,探月魔药,宇宙魔薬,,,,
material_apotheosis_hidden_liquid_magic_catalyst,Magic Catalyst,,,,,,,,魔法催发体,魔法の結晶体,,,,
material_apotheosis_hidden_liquid_wand_essence,Magus Elixir,,,,,,,,巫师秘药,エリクサー,,,,
material_apotheosis_sunkenrock,Sunken Rock,,,,,,,,水底岩石,水底の岩,,,,
material_apotheosis_sunkenrock_sandy,Sandy Rock,,,,,,,,砂质岩石,砂状の岩,,,,
material_apotheosis_ambrosia_dull,Infected Ambrosia,,,,,,,,被污染的神佑魔药,汚染されたアンブロシア,,,,
material_apotheosis_meat_slime_blue,Blue Slimy Meat,,,,,,,,蓝色发粘的肉,青いスライムの肉,,,,
material_apotheosis_meat_homing,Writhing Meat,,,,,,,,蠕动的肉,苦悶の肉,,,,
material_apotheosis_malicious_powder,Volcanic Powder,,,,,,,,火山粉末,恐ろしい粉末,,,,
material_apotheosis_milk,Milk,,,,,,,,牛奶,ミルク,,,,
material_apotheosis_milk_polymorph,Pilk,,,,,,,,变形牛奶,多形性型ミルク,,,,
material_apotheosis_unholy_concoction,Unholy Concoction,,,,,,,,邪恶混合物,邪悪な調合薬,,,,
material_apotheosis_esoteric_stone,Esoteric Stone,,,,,,,,神秘石头,深遠な力のこもった石,,,,
material_apotheosis_esoteric_stone_glowing,Luminescent Rock,,,,,,,,发光岩石,謎の光を放つ石,,,,
material_apotheosis_crystal_glow,Glowing Crystal,,,,,,,,发光水晶,光るクリスタル,,,,
material_apotheosis_cursed_rock_hard,Sacred Rock,,,,,,,,神圣岩石,聖なる岩,,,,
material_apotheosis_radioactive_liquid_strong,Noxious Sludge,,,,,,,,剧毒淤泥,激毒ヘドロ,,,,
material_apotheosis_radioactive_mud,Defiled Mud,,,,,,,,玷污泥土,汚染された泥,,,,
material_apotheosis_milk_powder,Powdered Milk,,,,,,,,奶粉,粉ミルク,,,,
material_apotheosis_meat_vulnerable_protection,Ancient Meat,,,,,,,,古老的肉,古代の肉,,,,
material_apotheosis_meat_worm_strong,Worm Plating,,,,,,,,蠕虫表皮,ウォームメッキ,,,,
magic_liquid_berserk_cloud_name,Berserkium Mist,,,,,,,,狂暴魔药雾,バーサキアムのミスト,,,,
magic_liquid_charm_cloud_name,Pheromone Mist,,,,,,,,魅惑魔药雾,フェロモンのミスト,,,,
spell_apotheosis_spells_to_cursor_name,Redirect,,,,,,,,重新导向,繰気弾,,,,
spell_apotheosis_spells_to_cursor_desc,Redirects all airborne projectiles towards your mouse cursor at a high speed,,,,,,,,令空中的所有投射物快速飞向你的瞄准位置。,空中にある全ての放射物をマウスカーソルのある方向に飛ばす。,,,,
spell_apotheosis_status_drunk_intense_name,Intense Mass Drunk,,,,,,,,,,,,DOESN'T NEED TO BE TRANSLATED,
spell_apotheosis_status_drunk_intense_desc,Affects every creature in a large radius a short but intense curse of endless spirits.,,,,,,,,,,,,DOESN'T NEED TO BE TRANSLATED,
spell_apotheosis_status_wet_intense_name,Intense Mass Wet,,,,,,,,,,,,DOESN'T NEED TO BE TRANSLATED,
spell_apotheosis_status_wet_intense_desc,Soaks every creature in a large radius with a short but intense curse of magical wetness.,,,,,,,,,,,,DOESN'T NEED TO BE TRANSLATED,
spell_apotheosis_status_fire_intense_name,Intense Mass Fire,,,,,,,,,,,,DOESN'T NEED TO BE TRANSLATED,
spell_apotheosis_status_fire_intense_desc,Burns every creature in a large radius with a dying but more damaging magical fire.,,,,,,,,,,,,DOESN'T NEED TO BE TRANSLATED,
spell_apotheosis_status_urine_intense_name,Intense Mass Jarate,,,,,,,,,,,,DOESN'T NEED TO BE TRANSLATED,
spell_apotheosis_status_urine_intense_desc,Douses every creature in a large radius with a short but intense curse of magical jarate.,,,,,,,,,,,,DOESN'T NEED TO BE TRANSLATED,
spell_apotheosis_status_polymorph_intense_name,Mass Chaotic Polymorph,,,,,,,,群体混乱变形,カオス変身フィールド,,,,
spell_apotheosis_status_polymorph_intense_desc,Afflicts every creature in a large radius with a magical chaotic polymorphine,,,,,,,,用混乱变形魔法影响大范围内的所有生物,周囲の生物を別の生物に変身させる。,,,,
spell_apotheosis_mass_burrow_name,Kaivossade,,,,,,,,清除地形,Kaivossade,,,,
spell_apotheosis_mass_burrow_desc,Rapidly excavate a large amount of terrain,,,,,,,,快速清除大量地形,広範囲の地形を破壊する。,,,,
spell_apotheosis_status_dry_name,Mass Infiltration,,,,,,,,群体渗透,浸潤フィールド,,,,
spell_apotheosis_status_dry_desc,Freezes the stains on every creature in a large radius with a magical spell,,,,,,,,固定大范围内所有生物身上的沾湿效果,周囲の生物の濡れ状態を現在の状態で固定する。,,,,
spell_apotheosis_autofire_name,Auto-Fire,,,,,,,,自动施法,Aimbot,,,,
spell_apotheosis_autofire_desc,Causes the wand to automatically shoot if there's nearby enemies,,,,,,,,令魔杖在附近有敌人时自动施法,杖が近くの生物を自動で攻撃する。,,,,
spell_apotheosis_upgrade_alwayscast_name,Spell Infusion,,,,,,,,法术注入,常時詠唱化,,,,
spell_apotheosis_upgrade_alwayscast_desc,The first spell slotted in your wand will be applied to the wand as an always cast. Spell is voided upon use!,,,,,,,,将魔杖中第一个法术注入魔杖，使其成为始终施放。此法术在使用后消失。,1番目のスロットにセットされた魔法が常時詠唱になる。このスペル自身は1度使うと消滅する。,,,,
spell_apotheosis_alt_fire_swapper_name,Alt Fire Swapper Bolt,,,,,,,,副法术 - 交换者,スワッパーボルト(ALT),,,,
spell_apotheosis_alt_fire_swapper_desc,Right Click to fire a projectile that swaps your position with the target's,,,,,,,,(右键施放)令被投射物击中的目标与你的位置交换,右クリックするとスワッパーボルトを発射する。,,,,
spell_apotheosis_alt_fire_cov_name,Alt Fire Circle of Vigour,,,,,,,,副法术 - 活力之环,気力の輪(ALT),,,,
spell_apotheosis_alt_fire_cov_desc,Right Click to cast a field of regenerative magic,,,,,,,,(右键施放)再生魔法的领域,右クリックすると気力の輪を発射する。,,,,
spell_apotheosis_alt_fire_cov_hardcore_desc,Right Click to cast a field of regenerative magic; Uncopyable.,,,,,,,,(右键施放)再生魔法的领域; 无法被其他法术复制,右クリックすると気力の輪を発射する。文字呪文でコピーできない。,,,,
spell_apotheosis_alt_fire_targetter_name,Alt Fire Targetter,,,,,,,,副法术 - 众矢之的,ロックオン(ALT),,,,
spell_apotheosis_alt_fire_targetter_desc,Right Click to fire a projectile which causes irresistible hatred towards anything it hits,,,,,,,,(右键施放)将万千仇恨施加于目标的法术,右クリックするとロックオンが発射される。,,,,
spell_apotheosis_alt_fire_alpha_name,Alt Fire Alpha,,,,,,,,副法术 - 阿尔法,,,,DOESN'T NEED TO BE TRANSLATED,
spell_apotheosis_alt_fire_alpha_desc,Right Click to cast a copy of the first spell in your wand for 40 mana,,,,,,,,(右键施放)消耗 40 魔力施放魔杖中第一个法术的复制品,,,,DOESN'T NEED TO BE TRANSLATED,
spell_apotheosis_critical_drunk_name,Critical on Drunk,,,,,,,,醉酒敌人暴击,酩酊クリティカル,,,,
spell_apotheosis_critical_drunk_desc,Make a projectile always do a critical hit on drunk enemies,,,,,,,,令投射物对醉酒敌人始终暴击,酔っぱらった状態の敵に確定クリティカルが発生する。,,,,
spell_apotheosis_affluence_name,Affluence,,,,,,,,财富,大富豪,,,,
spell_apotheosis_affluence_desc,Creatures hit by your projectiles drop extra gold,,,,,,,,被你的投射物击中的生物掉落额外的金块,放射物に当たった敵が追加でゴールドを落とす。,,,,
spell_apotheosis_liquidsphere_acid_name,Sphere of Acid,,,,,,,,酸液巨球,アシッドスフィア,,,,
spell_apotheosis_liquidsphere_acid_desc,"Cast a powerful sphere of acid, melting everything in its path",,,,,,,,施放一个强大的酸液巨球，溶解路径上的一切,触れたものを溶かす、強力な酸の玉を撃ち出す。,,,,
spell_apotheosis_liquidsphere_water_name,Sphere of Water,,,,,,,,清水巨球,ウォータースフィア,,,,
spell_apotheosis_liquidsphere_water_desc,"Cast an enduring sphere of water, soaking everything in its path",,,,,,,,施放一个持久的清水巨球，淹没路径上的一切,触れたものをずぶ濡れにする、水の玉を撃ち出す。,,,,
spell_apotheosis_liquidsphere_teleportatium_name,Sphere of Teleportatium,,,,,,,,传送魔药巨球,テレポートスフィア,,,,
spell_apotheosis_liquidsphere_teleportatium_desc,"Cast a malicious sphere of teleportatium, relocating everything in its path",,,,,,,,施放一个恶意的传送魔药巨球，排除路径上的一切,触れたものをどこかへと転送する、テレポータチアムの輪を撃ち出す。,,,,
spell_apotheosis_star_shot_name,Star Shot,,,,,,,,星弹,シューティングスター,,,,
spell_apotheosis_star_shot_desc,Fire two starry projectiles with a bright light,,,,,,,,发射两颗明亮的投射物。它们闪烁着星星的光芒,輝く2発の星を撃ち出す。,,,,
spell_apotheosis_hex_water_name,Vulnerability Hex - Water,,,,,,,,弱点诅咒 - 水,弱る呪い - 水,,,,
spell_apotheosis_hex_water_desc,Creatures hit by your projectiles take damage from water and other wet substances,,,,,,,,令投射物击中的生物受到来自水和其它潮湿物质的伤害,放射物に当たった敵が水でダメージを受けるようになる。,,,,
spell_apotheosis_hex_oil_name,Vulnerability Hex - Oil,,,,,,,,弱点诅咒 - 油,弱る呪い - オイル,,,,
spell_apotheosis_hex_oil_desc,Creatures hit by your projectiles take damage from oil and other oily substances,,,,,,,,令投射物击中的生物受到来自油和其它油性物质的伤害,放射物に当たった敵がオイルでダメージを受けるようになる。,,,,
spell_apotheosis_hex_blood_name,Vulnerability Hex - Blood,,,,,,,,弱点诅咒 - 血,弱る呪い - 血,,,,
spell_apotheosis_hex_blood_desc,Creatures hit by your projectiles take damage from blood and other bloody substances,,,,,,,,令投射物击中的生物受到来自血和其它血腥物质的伤害,放射物に当たった敵が血でダメージを受けるようになる。,,,,
spell_apotheosis_mist_attunium_name,Attunium Mist,,,,,,,,校准云雾,調律の霊薬のミスト,,,,
spell_apotheosis_mist_attunium_desc,A cloud of attunium mist,,,,,,,,校准魔药雾构成的云,霧状になった調律の霊薬。,,,,
spell_apotheosis_homing_delayed_name,Delayed Homing,,,,,,,,延迟追踪,遅延ホーミング,,,,
spell_apotheosis_homing_delayed_desc,Makes a projectile accelerate towards your foes after a short delay,,,,,,,,令投射物在短暂延迟后加速向你的敌人飞去,放射物が少し時間を置いてから敵にホーミングする。,,,,
spell_apotheosis_material_slime_name,Slime,,,,,,,,粘液,スライム,,,,
spell_apotheosis_material_slime_desc,Transmute globs of slime out of nothing!,,,,,,,,凭空产生的粘液！,スライムの液体を召喚する！,,,,
spell_apotheosis_material_alcohol_name,Whiskey,,,,,,,,威士忌,ウィスキー,,,,
spell_apotheosis_material_alcohol_desc,Transmute drops of whiskey out of nothing!,,,,,,,,凭空产生的威士忌！,ウィスキーを召喚する！,,,,
spell_apotheosis_material_confuse_name,Flummoxium,,,,,,,,混乱魔药,フルモキシウム,,,,
spell_apotheosis_material_confuse_desc,Transmute drops of flummoxium out of nothing!,,,,,,,,凭空产生的混乱魔药！,フルモキシウムを召喚する！,,,,
spell_apotheosis_material_copper_name,Copper,,,,,,,,铜,銅,,,,
spell_apotheosis_material_copper_desc,Transmute grains of copper out of nothing!,,,,,,,,凭空产生的铜！,銅の粉末を召喚する！,,,,
spell_apotheosis_material_fungi_name,Fungus,,,,,,,,真菌,きのこ,,,,
spell_apotheosis_material_fungi_desc,Transmute fungal sprouts out of nothing!,,,,,,,,凭空产生的真菌！,きのこの胞子を召喚する！,,,,
spell_apotheosis_death_cross_omega_name,Omega Death Cross,,,,,,,,终结死亡十字,オメガ死の十字架,,,,
spell_apotheosis_death_cross_omega_desc,"A violent, giant, deadly energy cross that explodes after a short time",,,,,,,,短暂时间后爆炸的暴力巨大致命能量十字,一定時間後に爆発する、十字架状の巨大な高エネルギー体。,,,,
spell_apotheosis_mudman_slimy_name,Transmute into Mutamies on Slimy Enemies,,,,,,,,粘液敌人突变,スライミー変身,,,,
spell_apotheosis_mudman_slimy_desc,Make a projectile transmute a creature into Mutamies upon collision if it's covered in slime,,,,,,,,令投射物在碰撞覆盖有粘液的生物时将其转化为突变体,放射物に当たった敵がスライム濡れ状態の時、その生物を変身させる。,,,,
spell_apotheosis_cloud_gunpowder_name,Gunpowder Cloud,,,,,,,,火药云,,,,DOESN'T NEED TO BE TRANSLATED,
spell_apotheosis_cloud_gunpowder_desc,Creates a rain of gunpowder,,,,,,,,产生一阵火药之雨,,,,DOESN'T NEED TO BE TRANSLATED,
spell_apotheosis_cloud_volcanic_name,Volcanic Cloud,,,,,,,,火山云,火山の雲,,,,
spell_apotheosis_cloud_volcanic_desc,Creates a volcanic rain of lava and ash,,,,,,,,产生一阵熔岩之雨,溶岩や灰を降らせる雲。,,,,
spell_apotheosis_noragdoll_name,Corpse Sublimation,,,,,,,,尸体升华,,,,DOESN'T NEED TO BE TRANSLATED,
spell_apotheosis_noragdoll_desc,Magically converts an enemy's corpse to smoke on death,,,,,,,,将敌人的尸体转化为烟,,,,DOESN'T NEED TO BE TRANSLATED,
spell_apotheosis_trail_enhancer_name,Trail Enhancer,,,,,,,,轨迹增强器,痕跡エンハンサー,,,,
spell_apotheosis_trail_enhancer_desc,Significantly increase the amount of material produced by other trail spells in the wand,,,,,,,,显著增加其他轨迹法术产生的材料数量,痕跡魔法で発生する物質の量を増加させる。,,,,
spell_apotheosis_trail_reducer_name,Trail Reducer,,,,,,,,轨迹削减器,,,,DOESN'T NEED TO BE TRANSLATED,
spell_apotheosis_trail_reducer_desc,Significantly reduce the amount of material produced by other trail spells in the wand,,,,,,,,显著减少其他轨迹法术产生的材料数量,,,,DOESN'T NEED TO BE TRANSLATED,
spell_apotheosis_larpa_delayed_name,Burst Larpa,,,,,,,,爆发拉帕,バースト幼生,,,,
spell_apotheosis_larpa_delayed_desc,Make a projectile cast a burst of copies after a short delay,,,,,,,,令投射物在短暂延迟后爆发出自身的复制品,少し時間を置いてから、放射物のコピーを大量に発生させる。,,,,
spell_apotheosis_random_homing_name,Random Homing,,,,,,,,随机追踪法术,ランダムホーミング,,,,
spell_apotheosis_random_homing_desc,Cast one random homing spell,,,,,,,,随机施放一个追踪类修正法术,いずれかのホーミング系スペルの効果が放射物に付与される。,,,,
spell_apotheosis_lua_sharing_name,Magic Inebriation,,,,,,,,魔法紊乱,魔法効果シェア,,,,
spell_apotheosis_lua_sharing_desc,Wildly diffuses the magical properties of different projectiles amongst each other,,,,,,,,令投射物的魔法属性彼此混合,同時詠唱した全ての放射物が、それぞれの持つ特性を共有する。,,,,
spell_apotheosis_gluecharge_name,Glue Charge,,,,,,,,黏胶放射,のりチャージ,,,,
spell_apotheosis_gluecharge_desc,"Imbues a projectile with a sticky charge, that it will release on impact",,,,,,,,令投射物在击中时散发黏胶放射,のりの力を放射物に込める。力は着弾地点で解放される。,,,,
spell_apotheosis_electrosphere_name,Bolt Orb,,,,,,,,电弧魔球,ボルトオーブ,,,,
spell_apotheosis_electrosphere_desc,Cast a slow orb which zaps nearby creatures periodically,,,,,,,,施放一个向附近生物放出电击的缓慢魔球,一定時間ごとに周囲の生物を攻撃するオーブ。,,,,
spell_apotheosis_sea_berserk_name,Sea of Berserkium,,,,,,,,狂暴魔药之海,バーサキアムの海,,,,
spell_apotheosis_sea_berserk_desc,Summons a large body of Berserkium below the caster,,,,,,,,将施术者下方的大片区域充满狂暴魔药,詠唱者の真下にバーサキアムの海を作り出す。,,,,
spell_apotheosis_kindness_to_power_name,Kindness to Power,,,,,,,,友情转力量,友情パワー,,,,
spell_apotheosis_kindness_to_power_desc,Increase critical hit chance proportional to how many charmed creatures are nearby,,,,,,,,根据附近的被魅惑的生物数量，提升一个投射物的暴击率,周囲にいる魅了状態の敵の数に応じ、クリティカル確率が上昇する。,,,,
spell_apotheosis_mind_vision_name,Mind Vision,,,,,,,,心灵之眼,マインドビジョン,,,,
spell_apotheosis_mind_vision_desc,Creatures hit by a projectile are temporarily revealed through fog of war,,,,,,,,令被投射物击中的生物暂时从黑暗中显现,放射物に当たった敵の姿が暗闇の中でも見えるようになる。,,,,
spell_apotheosis_water_power_name,Hydromancy,,,,,,,,水占术,水魔法,,,,
spell_apotheosis_water_power_desc,Reduce mana cost by 30 and increase fire rate when wet,,,,,,,,浸水时向法杖注入 30 魔力并缩短法术施放之间的时间间隔,詠唱者が水濡れ状態の時、消費マナと魔法の発射レートが上昇する。,,,,
spell_apotheosis_fire_power_name,Pyromancy,,,,,,,,火占术,火魔法,,,,
spell_apotheosis_fire_power_desc,Amplify and convert all damage to fire damage when burning,,,,,,,,燃烧时将所有类型的伤害提升并转换为火焰伤害,詠唱者が炎上状態の時、消費マナと魔法の発射レートが上昇する。,,,,
spell_apotheosis_blood_power_name,Hemomancy,,,,,,,,血占术,血魔術,,,,
spell_apotheosis_blood_power_desc,Projectiles will pierce 5 times when bloody,,,,,,,,染血时投射物能够穿刺 5 次,詠唱者が血濡れ状態の時、呪文が5ヒットするようになる。,,,,
spell_apotheosis_shape_wall_name,Formation - Wall,,,,,,,,阵型 - 墙,編隊 - 壁,,,,
spell_apotheosis_shape_wall_desc,Casts 5 spells in a wall-shaped pattern,,,,,,,,以竖墙形式施放 5 个法术,5つの魔法を壁状の編隊で発射する。,,,,
spell_apotheosis_shot_wall_name,Wallplicate,,,,,,,,阵型复制 - 墙,複製 - 壁,,,,
spell_apotheosis_shot_wall_desc,"Casts 5 copies of a projectile in a wall-shaped pattern, but the copies still cost mana",,,,,,,,以竖墙阵型施放 5 个投射物的复制品，复制品同样消耗法力,呪文を5つに複製し、壁状の編隊で発射する。コピーされた魔法もマナを消費する。,,,,
spell_apotheosis_summon_star_child_name,Summon Star Child,,,,,,,,,,,,DOESN'T NEED TO BE TRANSLATED,
spell_apotheosis_summon_star_child_desc,Summons a celestial familiar,,,,,,,,,,,,DOESN'T NEED TO BE TRANSLATED,
spell_apotheosis_fire_wall_name,Wall of Fire,,,,,,,,火之障壁,ファイアーウォール,,,,
spell_apotheosis_fire_wall_desc,Summons a wall of fire to ward off foes,,,,,,,,召唤一堵火焰墙壁来抵御敌人,炎の壁が敵を焼き尽くす。,,,,
spell_apotheosis_random_burst_name,Random Cast,,,,,,,,随机多重施法,ランダム同時詠唱,,,,
spell_apotheosis_random_burst_desc,Multicasts between 4 to 8 random spells,,,,,,,,同时施放 4-8 个法术,4-8個の魔法を同時に詠唱する。,,,,
spell_apotheosis_jumper_cables_name,Summon Jumper Cables,,,,,,,,召唤跨接电缆,電線の召喚,,,,
spell_apotheosis_jumper_cables_desc,Summon a pair of electrifying vices to shock your victims,,,,,,,,召唤电缆带电的两端来电击你的敌人,触れたものを感電させる線を召喚する。,,,,
spell_apotheosis_chi_name,Chi,,,,,,,,希,カイ,,,,
spell_apotheosis_chi_desc,Copies every utility-type spell in the wand when cast,,,,,,,,施放魔杖中所有实用法术的复制品,杖にあるすべてのユーティリティ系魔法のコピーを詠唱する。,,,,
spell_apotheosis_kappa_name,Kappa,,,,,,,,卡帕,Kappa,,,,
spell_apotheosis_kappa_desc,Copies every alt fire-type spell in the wand when cast,,,,,,,,施放魔杖中所有副法术的复制品,杖にあるすべてのALT系魔法のコピーを詠唱する。,,,,
spell_apotheosis_pollen_trigger_name,Pollen with Trigger,,,,,,,,带有触发的花粉,トリガー付き花粉,,,,
spell_apotheosis_pollen_trigger_desc,"A small, floating projectile that casts another spell upon collision",,,,,,,,小小的飘浮投射物，在碰撞时施放另一法术,着弾時に後ろの魔法を詠唱する花粉。,,,,
spell_apotheosis_rubberball_trigger_name,Bouncing Burst with Expiration Trigger,,,,,,,,带有失效触发的弹跳爆发,消滅トリガー付きバウンドバースト,,,,
spell_apotheosis_rubberball_trigger_desc,A very bouncy projectile that casts another spell upon expiration,,,,,,,,极具弹跳力的投射物，在失效时释放另一法术,消滅時に後ろの魔法を詠唱するバウンドバースト,,,,
spell_apotheosis_potion_to_sea_name,Potion to Sea,,,,,,,,瓶中之海,ポーションの海,,,,
spell_apotheosis_potion_to_sea_desc,The first flask in your inventory is shattered and converted into a sea of the same material,,,,,,,,粉碎你物品栏中的第一瓶材料，并将下方大片区域充满同种材料,インベントリの最も左側にあるポーション瓶を消滅させ、中に入っていた物質の海を出現させる。,,,,
spell_apotheosis_toilet_paper_name,Conjure Roll of Divine Purification,,,,,,,,呼唤神圣净化之卷,禊の巻紙,,,,
spell_apotheosis_toilet_paper_desc,Summons a roll of toilet paper,,,,,,,,召唤一卷厕纸,トイレットペーパーを召喚する。,,,,
actiondesc_mana_reduce,Adds 30 mana to the wand,Добавляет жезлу 30 ед           . маны,Adiciona 30 de mana à varinha,Añade 30 maná a la varita,Fügt dem Zauberstab 30 Mana hinzu,Ajoute 30 points de mana à la baguette,Aggiunge 30 punti mana alla bacchetta.,Dodaje do różdżki 30 pkt. many,向魔杖增加 30 法力,30マナを杖に追加する,완드에 마나 30을 추가합니다.,,,
spell_apotheosis_cov_desc,A field of regenerative magic; Uncopyable.,,,,,,,,再生魔法的领域; 无法被其他法术复制,回復魔法のフィールド。文字呪文でコピーできない。,,,,
spell_apotheosis_healing_bolt_desc,A magical bolt that heals other beings; Uncopyable.,,,,,,,,治疗其他生物的魔法弹; 无法被其他法术复制。,触れた者を回復する魔法弾。文字呪文でコピーできない。,,,,
spell_apotheosis_antiheal_desc,"A projectile that at first deals damage, then heals over time; Uncopyable.",,,,,,,,起初会造成伤害，然后开始持续治疗的投射物; 无法被其他法术复制。,最初はダメージを与え、時間とともに回復する放射物。文字呪文でコピーできない。,,,,
spell_apotheosis_touch_grass_desc,"Transmutes everything in a short radius into Earth, including walls, creatures... and you. Unless…; Uncopyable",,,,,,,,将附近的一切转化为土壤，包括墙壁、生物……还有你自己。除非……; 无法被其他法术复制。,周囲にあるすべてのものを土に変化させる。これには壁、生物...そしてあなた自身がふくまれる。ただし…文字呪文でコピーできない。,,,,
spell_apotheosis_sea_mimic_desc,Summons a large body of mimicium under the caster; Uncopyable,,,,,,,,在施法者脚下召唤一个巨大的拟态体; 无法被其他法术复制。,詠唱者の下にある大きなエリアをミミキウムで満たす。文字呪文でコピーできない。,,,,
spell_apotheosis_piercing_shot_desc_old,"Makes a projectile penetrate 5 times, but become harmful to the caster",,,,,,,,令投射物能够穿透敌人 5 次，但对施放者也可造成伤害,放射物が敵に5ヒットするが、自傷効果を持つようになる。,,,,
spell_apotheosis_piercing_shot_desc,Makes a projectile penetrate 5 times,,,,,,,,令投射物能够穿透敌人 5 次,放射物が敵に5ヒットする。,,,,
spell_apotheosis_locked_spell_name,Faulty Magic,,,,,,,,失效的法术,封印されたスペル,,,,
spell_apotheosis_locked_spell_desc,It seems this magic is unusable after being afflicted by a curse.,,,,,,,,看起来这个被诅咒缠绕的法术已经无法使用了。,このスペルは呪いによって使用できない。,,,,
orb_apotheosis_12_desc,Secrets of controlling the arcane have been unlocked to you.,,,,,,,,操纵奥术的秘密已然向你开放。,アルカナを操る技が解放された。,,,,
orb_apotheosis_14_desc,Secrets of the drowning depths have been unlocked to you.,,,,,,,,沉溺深渊的秘密已然向你开放。,水に沈んだ知識が解放された。,,,,
orb_apotheosis_15_desc,Secrets of unworldly transmutation have been unlocked to you.,,,,,,,,奇异变形的秘密已然向你开放。,世界を作りかえる力が解放された。,,,,
orb_apotheosis_16_desc,Secrets of wild magic have been unlocked to you.,,,,,,,,疯狂魔法的秘密已然向你开放。,ワイルドな魔法の力が解放された。,,,,
book_apotheosis_orbbook_12_name,Emerald Tablet - Volume XI,,,,,,,,翡翠石板 - 卷十一,,,,,
book_apotheosis_orbbook_12_description,"The world shook asunder and cried in neither fear nor joy,\nnor anger nor sadness, nor any.\nnor the tears flew above or below, but to the east and west. \nThe world birth itself anew as it grew and took on new forms \nSome creatures were weary \nSome intrigued \nOthers excited \nMany unaware.",,,,,,,,世界震动得四分五裂，哭泣声既不恐惧也不喜悦，\n既不愤怒也不悲伤。\n泪水不向上或下飞，而是向东和西飞去。\n世界在成长，以新的形式诞生。\n一些生物警惕\n一些好奇\n一些兴奋\n更多的是浑然不知。,,,,,
book_apotheosis_orbbook_13_name,Emerald Tablet - Volume XII,,,,,,,,翡翠石板 - 卷十二,,,,,
book_apotheosis_orbbook_13_description,"There once was a time the world froze to a halt.\nThe water didn't flow, the heart didn't beat and the box didn't fall.\nAfter a moment time flowed again as it always did, however,\nsomething was missing afterwards.\nLook around you, do you not sense it?\nIt is our pursuit to discover what that thing was.",,,,,,,,曾经有一段时间，世界停滞了。\n水不再流动，心不再跳动，盒子也不再下落。\n片刻之后，时间又像往常一样流淌，然而，\n某种事物在那之后却消失了。\n看看你的周围，难道你感觉不到吗？\n我们的追求就是发觉那消失之物。,,,,,
book_apotheosis_orbbook_14_name,Emerald Tablet - Volume XIII,,,,,,,,翡翠石板 - 卷十三,,,,,
book_apotheosis_orbbook_14_description,"The bird cackled and sang\nWhat good is one's time if it is without encouragement?\nTo those who dream when they feel, they know not the encouragement\nof knowing what to do before their dream and how much.\nTo those who plan their dream ahead of time, when and where,\nthey know what they can do and what time they have to do it.\nThe bird cackled once more before it flew off.\nIt's wisdom soaked into the minds of those who heard it, \nas water soaked into glass.",,,,,,,,鸟儿咯咯叫着，唱道\n如果没有鼓励，时间又有何用处呢？\n对于那些凭感觉做梦的人来说，他们并不知道\n在实现梦想之前需要做什么以及需要多少鼓励。\n而那些提前计划梦想的人则知道何时、何地去行动，\n他们知道自己能做什么，有多少时间去做。\n鸟儿咯咯叫着飞走了。\n它的智慧浸透了听到它的人的心灵，\n就像水浸透了玻璃一样。,,,,,
book_apotheosis_orbbook_15_name,Emerald Tablet - Volume XIV,,,,,,,,翡翠石板 - 卷十四,,,,,
book_apotheosis_orbbook_15_description,"If only you knew how the mountains were made.\nHow the rivers flowed,\nWhy the emeralds were heavy,\nWhat creature made the eternal fire.\nOur art is not wrapped in layers of secrecy because we hide it.\nYou can know, but choose not to, and so are left with nothing to do but pray to your gods for salvation.",,,,,,,,如果你知道高山是如何形成的，\n河流是如何流动的，\n为什么翡翠如此沉重，\n何种生物创造了永恒之火，你就会明白。\n我们的技艺并没有因为我们的隐藏而被包裹在层层神秘中。\n你本可以知晓，但你选择不去探索，所以你只能向你的神祈求救赎。,,,,,
book_apotheosis_orbbook_stone_workinprogress_description,"Seeker of knowledge, your nose is on the right path \nyet some secrets are yet to be revealed.",,,,,,,,知识的寻求者，你的方向是对的。\n有些秘密还未被揭示。,,,,,
book_apotheosis_orbbook_stone_12_description,Evolution is forever changing.,,,,,,,,进化永远在变化。,,,,,
book_apotheosis_orbbook_stone_13_description,Bring your friends along when you travel.,,,,,,,,旅行时带上你的朋友们。,,,,,
book_apotheosis_orbbook_stone_14_description,"To gain true knowledge, one must remain pure and unintoxicated.",,,,,,,,要获得真知卓识，必须保持纯洁，不被迷惑。,,,,,
book_apotheosis_orbbook_stone_15_description,Attune with and home in on your goals;\nDo so and your arrow shall move faster.,,,,,,,,校准后瞄准你的目标，这样做你的箭就会飞得更快。,,,,,
book_apotheosis_playerghost_name,A Message From Beyond,,,,,,,,来自世界之外的信息,彼方からのメッセージ,,,,
book_apotheosis_playerghost_description,"To those who seek knowledge not true, but divine.\nOne should stand at the altar alone.",,,,,,,,寻求神圣知识，而非真正知识的人们，\n要独自站立在那圣坛之上。,,,,,
book_apotheosis_playerghost_description_temp,"To those who seek knowledge not true, but divine.\nOne should turn emerald knowledge to stone.",,,,,,,,寻求神圣知识，而非真正知识的人们，\n要将翡翠知识变为石头。,,,,,
book_apotheosis_materia_conversion_spell_description_new,Conversion.. \nRemember these words.... \nFungus \nWorm \nRat \nSpark \nMass \nLetter \nLifetime,Превращение... \nЗапомните эти слова.... \nГрибок \nЧервь \nКрыса \nИскровая \nМассовая \nБуква \nВремя,,,,,,,转化...\n记住这几个词....\n真菌\n蠕虫\n老鼠\n火花\n群体\n字母\n存在时间,,Kono kotoba wo oboete oku youni...\nKinoko \nWorm \nNezumi \nHibana \nフィールド,,,
book_apotheosis_material_spells_name,Lost Alchemy,,,,,,,,遗失的炼金术,失われた秘術,,,,
book_apotheosis_material_spells_description,"I used to commit alchemy here a long time ago, it was a safe hideaway where my brothers wouldn't bother me. \nHowever.. it seems these ants have taking a liking to it. \n..Never the matter, to my future self, the master of alchemy, \nturn this metal into a material which aids with flight, and your vault will be unlocked to you. \nIf you're someone who isn't me and you found this place, please leave what you found untouched.",,,,,,,,很久以前，我经常在这里炼金，这是个安全的藏身所，我的兄弟们不会来打扰我。\n不过...看起来这些蚂蚁似乎对这此处很感兴趣。\n...算了，对于未来的我，作为炼金术大师，\n请你把这块金属转换成有助于飞行的材料，你的金库就会向你敞开。\n如果你不是我并且你发现了这个地方，请不要碰任何东西。,,,,,
book_apotheosis_omegadeath_name,Death,,,,,,,,死亡,死神の言葉,,,,
book_apotheosis_omegadeath_description,"Follow my exact path only. I detailed it in the land containing the diamond. \nOnly the uninitiated will bare usefulness to this knowledge to avoid corruption among our ranks, \nso teach the right way to teleport only to those pure. \nThose who have strayed from my pathway will not be rewarded with death.",,,,,,,,只能按照我的路线前进。我在蕴含钻石的土地上详细描述了它。\n为避免我们队伍中的腐败，只有不知情者才能知道这些知识的用处，\n所以正确的传送方式只能传授给那些纯洁的人。\n那些偏离了我的道路的人将不会得到死亡的奖励。,,,,,
book_apotheosis_realquest_name,Day 7,,,,,,,,第七天,,,,,
book_apotheosis_realquest_description,"I've come here in search of the legendary Red Fish, I remember its name on the tip of my tongue..\nSomething starting with H.. yet I can't recall it\nNo matter, I'll name it after myself after I become the first to discover it.\nThen I'll never forget its name again!",,,,,,,,我来到这里寻找传说中的朱红鱼，我把它的名字记在嘴边...\n好像是 H 开头的.. 但我想不起来了\n没事的，等我成为第一个找到它的人后，我会给它起个名字。\n那样我就再也不会忘记它的名字了！,,,,,
book_apotheosis_realquest_alt_name,Day 297,,,,,,,,第二百九十七天,,,,,
book_apotheosis_realquest_alt_description,Remember.\nThe red fish is real.\nThe red fish is real.\nThe red fish is real.\nThe red fish is real.\nThe red fish is real\nThe red fish is reall\nThe red f,,,,,,,,切记。\n朱红鱼是真实存在的。\n朱红鱼是真实存在的。\n朱红鱼是真实存在的。\n朱红鱼是真实存在的。\n朱红鱼是真实存在的\n朱红鱼是真实存左的\n朱纟,,,,,
book_apotheosis_realquest_tale_name,Gone Fishing,,,,,,,,前去钓鱼,釣りの書,,,,
book_apotheosis_realquest_tale_description,"The grand red fish is divine bait, only with it will one catch \nthe grandest of beasts lying at the ocean's trench.\nFinding such a specimen often requires one's entire life however, \nand those who have tried often return without fruit or holding defeat.\nTales speak of the red fish coming to those who wait patiently at the water, \nbut only if your palm holds the right blessing.",,,,,,,,伟大的朱红鱼是种神圣的鱼饵，只有用它\n才能钓出海沟中潜藏的最庞大的野兽。\n然而寻求这种鱼饵却常常需要付出一生，\n尝试过的人也往往无功而返或抱憾而归。\n传说朱红鱼会靠近在水边耐心等待的人，\n但前提是你手中握有正确的祝福。,,,,,
book_apotheosis_materia_conversion,Materialist's Notes,,,,,,,,物质学家的笔记,マテリアについてのメモ,,,,
book_apotheosis_kings_name,Book of Kings,,,,,,,,王者之书,,,,,
book_apotheosis_kings_description,I once met a king from a far away land.\nHis knowledge was vast and endless.\nYet despite his power he still couldn't attain one thing.\nHe wished in his last moments to be united with the furthest true knowledge in this world.,,,,,,,,我曾经遇见一个来自遥远国度的国王。\n他的知识渊博无尽。\n然而，尽管他有着无比的力量，他仍然无法获得一件东西。\n在他生命的最后时刻，他希望与这个世界上最深刻的真理结合在一起。,,,,,
perk_apotheosis_shield_oversized_name,Oversized Shield,,,,,,,,巨大护盾,メガシールド,,,,
perk_apotheosis_shield_oversized_description,"You gain a very large, permanent shield.",,,,,,,,你获得一面非常大的永久护盾。,巨大な永久シールドが出現する。,,,,
perk_apotheosis_haste_name,Haste,,,,,,,,急速,電光石火,,,,
perk_apotheosis_haste_description,You move faster and levitate quicker.,,,,,,,,你移动和浮空得更快。,全方向への移動が速くなる。,,,,
perk_apotheosis_contactdamage_description,You take no damage from close-range enemy attacks but enemies near you take damage.,,,,,,,,接近你的敌人受到伤害，且敌人的近距离攻击不会对你造成伤害。,敵の近接攻撃を無力化し、近くの敵にダメージを与える。,,,,
perk_apotheosis_alcohol_immunity,Alcohol Immunity,,,,,,,,酒精免疫,ウワバミ,,,,
perk_apotheosis_alcohol_immunity_description,You take no effect to being drunk.,,,,,,,,醉酒不会对你造成影响。,酔いによるデメリットがなくなる。,,,,
perk_apotheosis_trip_immunity,Shift Immunity,,,,,,,,转换免疫,シフト耐性,,,,
perk_apotheosis_trip_immunity_description,The world is set in stone and can not be shifted so long as you live.,,,,,,,,世界稳如磐石，只要你活着，它就绝不会受到变换。,世界の物質が固定化され、きのこシフトが使えなくなる。,,,,
perk_apotheosis_no_recoil,No Recoil,,,,,,,,无后坐力,反動無効化,,,,
perk_apotheosis_no_recoil_description,Your spells have no recoil.,,,,,,,,你的法术没有后坐力。,スペルによる反動がなくなる。,,,,
perk_apotheosis_void,Void,,,,,,,,虚空,無,,,,
perk_apotheosis_void_description,"Gain immense power, but the void grows jealous of your options.",,,,,,,,获得强大的力量，但虚空越来越嫉妒你的天赋选择权。,強力な力を得られるが、無があなたの選択を徐々に狭めてゆく。,,,,
perk_apotheosis_infinite_flight,Our Gift,,,,,,,,恩赐,恩寵,,,,
perk_apotheosis_infinite_flight_description,A divine blessing grants you infinite flight.,,,,,,,,神圣的祝福使你能够无限飞行。,天からの恩寵により、無限に空を飛ぶ力を得る。,,,,
perk_apotheosis_infinite_flight_description_2,"A divine blessing grants you infinite flight.\nSo long, and thanks for all the fish!",,,,,,,,神圣的祝福使你能够无限飞行。\n再见，谢谢你的鱼！,天からの恩寵により、無限に空を飛ぶ力を得る。,,,,
perk_apotheosis_copy_spells,Copy Spells,,,,,,,,复制法术,呪文複製,,,,
perk_apotheosis_copy_spells_description,Copy the Uncopyable.,,,,,,,,原先不可复制的法术变得可复制了。,複製不可属性の付いた魔法が複製可能になる。,,,,
perk_apotheosis_curse_mana,Endless Mana,,,,,,,,无尽法力,無限のマナ,,,,
perk_apotheosis_curse_mana_reveal,Curse of Mana,,,,,,,,法力诅咒,マナの呪い,,,,
perk_apotheosis_curse_mana_description,Your wands feel terribly unstable.. but have infinite mana!,,,,,,,,你的法杖感觉很不稳定..但拥有无限法力！,無限のマナを得られるが、杖が不安定になる。,,,,
perk_apotheosis_curse_mana_description_reveal,You have infinite mana.. but feel horribly sick...,,,,,,,,你拥有无限的法力..但感觉非常不舒服...,無限のマナを得たが、ひどく気分が悪い。,,,,
perk_apotheosis_curse_mana_disrupt,Disrupted Mana,,,,,,,,法力中断,マナ詰まり,,,,
perk_apotheosis_curse_mana_disrupt_description,Your wands are unable to cast!,,,,,,,,你的法杖不能施法！,この杖はもう使い物にならない。,,,,
perk_apotheosis_no_blood,Smoked Corpses,,,,,,,,灰飞烟灭,ケムリ死体,,,,
perk_apotheosis_no_blood_description,"Enemies leave behind no corpse, and bleed no blood.",,,,,,,,敌人死亡时不会留下尸体，也不会流血。,敵が死体を残さず、血も流さなくなる。,,,,
perk_apotheosis_god_ti,Divine Intervention,,,,,,,,神圣干预,神々の試練,,,,
perk_apotheosis_god_ti_description,The gods will cause something sporadic to occur every 3-4 minutes.,,,,,,,,众神每 3 至 4 分钟显露些许神迹。,3-4分ごとに神々が様々な試練をあなたに課す。,,,,
perk_apotheosis_plane_radar,Divine Radar,,,,,,,,神圣雷达,神通力,,,,
perk_apotheosis_plane_radar_description,You can sense otherworldy energy somewhere in the world.,,,,,,,,可以感应世界某处的异界能量。,世界のどこかに流れる、異界の力を感じられるようになる。,,,,
perk_apotheosis_respawn_spent,Extra Life (Spent),,,,,,,,额外生命（已消耗）,追加ライフ（使用済み）,,,,
perk_apotheosis_respawn_spent_description,This extra life has been spent and is no longer usable.,,,,,,,,这条额外生命已被消耗，不再能保护你。,使用済みの追加ライフ。効果が消失している。,,,,
status_apotheosis_nohealing_name,Wounded,,,,,,,,受创,負傷,,,,
status_apotheosis_nohealing_desc,You can not be healed.,,,,,,,,各类治疗魔法无法治疗你。,回復魔法の効果がない。,,,,
status_apotheosis_teleport_cancel_name,Teleport Nullification,,,,,,,,传送无效化,テレポート無効化,,,,
status_apotheosis_teleport_cancel_desc,You can no longer teleport,,,,,,,,你无法进行传送。,テレポートできない。,,,,
status_apotheosis_magicwet_intense_ui,Intense Wetness,,,,,,,,强烈潮湿,強烈な湿気,,,,
status_drunk_intense_ui,Aura of Spirits,,,,,,,,灵魂光环,スピリッツのオーラ,,,,
status_apotheosis_magicurine_intense_ui,Magic Incontinence,,,,,,,,魔法失禁,きたない魔力,,,,
status_apotheosis_magicfire_intense_ui,Cursed Flames,,,,,,,,诅咒火焰,邪悪な炎,,,,
status_apotheosis_dry_spell_name,Infiltrated,,,,,,,,固定脏污,浸潤,,,,
status_apotheosis_dry_spell_desc,"Your stains are set in stone, nothing can be removed and nothing can be added.",,,,,,,,你的脏污效果已固定，无法去除，也无法获得新的脏污。,濡れ状態が固定化されている。,,,,
status_apotheosis_dry_spell_cooldown_name,Exfiltrated,,,,,,,,无法固定脏污,乾燥,,,,
status_apotheosis_dry_spell_cooldown_desc,"Your skin feels spongy, your stains can temporarily not be set in stone.",,,,,,,,你的皮肤感觉像海绵一样，你的脏污效果暂时无法固定。,肌の状態が元通りに戻った。濡れ状態の固定化が解除された。,,,,
status_apotheosis_infinite_flight_name,Limitless Flight,,,,,,,,无限飞行,無限飛行,,,,
status_apotheosis_infinite_flight_desc,You can fly forever.,,,,,,,,你可以一直飞。,無限に空を飛べるようになった。,,,,
status_apotheosis_escapium_name,Safe Escape,,,,,,,,安全逃生,逃げの達人,,,,
status_apotheosis_escapium_desc,"A protective barrier shields you, and you feel faster.",,,,,,,,一道保护屏障将你护住，并且你移动更快。,バリアが出現し、さらに移動速度が上昇している。,,,,
status_apotheosis_projectile_immunity_name,Projectile Assimilation,,,,,,,,投射物吸收,放射物エネルギー吸収,,,,
status_apotheosis_projectile_immunity_desc,You heal from projectiles.,,,,,,,,投射物会使你回复生命值。,放射物で回復できるようになった。,,,,
status_apotheosis_homing_name,Projectile Attunement,,,,,,,,魔法校准,魔法調律,,,,
status_apotheosis_homing_desc,Your spells seek targets automatically.,,,,,,,,你的法术自动寻找目标。,スペルがひとりでに敵を狙うようになった。,,,,
status_apotheosis_light_reflect_name,Magical Light,,,,,,,,魔法之光,魔法の光,,,,
status_apotheosis_light_reflect_desc,Taking damage causes you to retaliate with a beam of light.,,,,,,,,你受到伤害会反射一束复仇光线,ダメージを負うと、ビームを放って反撃する。,,,,
status_apotheosis_breath_drain_name,Suffocating,,,,,,,,窒息,窒息,,,,
status_apotheosis_breath_drain_desc,You are rapidly loosing oxygen!!,,,,,,,,你快速地失去氧气！,酸素が急激に失われていく。,,,,
status_apotheosis_speedup_name,Accelerated Velocity,,,,,,,,加速,超加速,,,,
status_apotheosis_speedup_desc,Your spells feel significantly faster.,,,,,,,,你的法术明显快了许多。,とても速く動けるようになった。,,,,
status_apotheosis_clear_status_name,Pure Stomach,,,,,,,,净胃,ピュアな胃袋,,,,
status_apotheosis_clear_status_desc,Your stomach is clear from negative effects you've ingested.,,,,,,,,你不会受到摄取物质的负面效果。,食べ物によるマイナス効果がなくなる。,,,,
status_apotheosis_rideshare_name,Portalic Rideshare,,,,,,,,传送携带,いっしょにテレポート,,,,
status_apotheosis_rideshare_desc,You feel nearby creatures will follow you through portals.,,,,,,,,你感觉附近的生物会跟随你穿过传送门。,テレポートした時、周囲の敵もついて来るようになる。,,,,
status_apotheosis_hex_water_name,Abyssal Hex,,,,,,,,深渊诅咒,アビスの呪い,,,,
status_apotheosis_hex_water_desc,You take damage from water and other wet substances.,,,,,,,,你受到来自水和其他潮湿物质的伤害。,水でダメージを受けるようになった。,,,,
status_apotheosis_hex_oil_name,Industrious Hex,,,,,,,,机械诅咒,機械の呪い,,,,
status_apotheosis_hex_oil_desc,You take damage from oil and other oily substances.,,,,,,,,你受到来自油和其他油性物质的伤害。,オイルでダメージを受けるようになった。,,,,
status_apotheosis_hex_blood_name,Lively Hex,,,,,,,,血肉诅咒,生命の呪い,,,,
status_apotheosis_hex_blood_desc,You take damage from blood and other bloody substances.,,,,,,,,你受到来自血和其他血腥物质的伤害。,血でダメージを受けるようになった。,,,,
status_apotheosis_hex_radioactive_name,Virulent Hex,,,,,,,,毒性诅咒,免疫弱化の呪い,,,,
status_apotheosis_hex_radioactive_desc,You take additional damage from toxic sludge and other toxic substances.,,,,,,,,你额外受到来自毒性淤泥和其他毒性物质的伤害。,猛毒ヘドロなどの毒性物質によって受けるダメージが増加する。,,,,
status_apotheosis_protection_all_dull_name,Shattered Protection,,,,,,,,保护破碎,無防備状態,,,,
status_apotheosis_protection_all_dull_desc,"Provides no protection, spreads to nearby ambrosia.",,,,,,,,并不会提供保护。会传染给附近的神佑魔药,防御系の効果が無効化される。周囲のアンブロシアも効果がなくなる。,,,,
status_apotheosis_infusion_vulnerability_name,Vulnerable Infusion,,,,,,,,易伤附加,弱体化属性,,,,
status_apotheosis_infusion_vulnerability_desc,Your attacks inflict vulnerability.,,,,,,,,你的攻击附带易伤效果。,あなたの攻撃が、敵に弱体化の効果を与えるようになる。,,,,
status_apotheosis_infusion_hex_water_name,Water Hex Infusion,,,,,,,,清水诅咒附加,水呪い属性,,,,
status_apotheosis_infusion_hex_water_desc,Your attacks inflict Abyssal Hex.,,,,,,,,你的攻击附带深渊诅咒。,あなたの攻撃が、敵に水の呪いを与えるようになる。,,,,
status_apotheosis_infusion_freeze_name,Freezing Infusion,,,,,,,,冻结附加,凍結属性,,,,
status_apotheosis_infusion_freeze_desc,Your attacks inflict Freeze.,,,,,,,,你的攻击附带冻结效果。,あなたの攻撃に凍結効果が付与される。,,,,
status_apotheosis_no_flight_name,Grounded,,,,,,,,无法飞行,飛行禁止,,,,
status_apotheosis_no_flight_desc,You are unable to levitate.,,,,,,,,你无法浮空。,空を飛べなくなる。,,,,
status_apotheosis_creature_shifted_name,The evolution has shifted,,,,,,,,生命的法则受到了变换,生命の姿が変化した,,,,
status_apotheosis_creature_shifted_desc,You sense life is no longer what it used to be.,,,,,,,,你对生命的感知变得不同以往。,生命の歴史が書き換わっていく。,,,,
status_apotheosis_shielddrain_name,Shield Instability,,,,,,,,破盾,シールド無効化,,,,
status_apotheosis_shielddrain_desc,Your plasma shields are neutralized and unable to defend you.,,,,,,,,你的魔法盾被中和，无法保护你。,エネルギーシールドの効果がなくなる。,,,,
status_apotheosis_mindvision_name,Mind Vision,,,,,,,,心灵之眼,心眼,,,,
status_apotheosis_mindvision_desc,You can see... yourself. Well done.,,,,,,,,你可以清楚地看见...你自己。干得真棒。,あなた自身の姿が見えるようになる。終わり！,,,,
status_apotheosis_anthatching_name,Ant Pheromones,,,,,,,,蚂蚁魅惑,アリのフェロモン,,,,
status_apotheosis_anthatching_desc,Ant eggs will prematurely hatch in your presence.,,,,,,,,蚁卵因你的存在而提前孵化。,周囲にあるアリの卵がひとりでにふ化する。,,,,
status_apotheosis_brain_damage_00_name,Brain Rot,,,,,,,,轻度脑部受损,脳障害,,,,
status_apotheosis_brain_damage_00_desc,You feel your mind ceasing to function.\nFurther consumption may be a mistake.,,,,,,,,你感觉你的意识正在停止运转。\n继续摄取是个错误。,精神に異常が起きている。\nこれ以上摂取しない方がよさそうだ。,,,,
status_apotheosis_brain_damage_01_name,Brain Rot,,,,,,,,中度脑部受损,脳障害,,,,
status_apotheosis_brain_damage_01_desc,You suffer permanent brain damage.\nFurther consumption may prove lethal.,,,,,,,,你受到了永久的脑损伤。\n继续摄取可能会致命。,脳が激しいダメージを受けている。\nこれ以上摂取すると、致命的な影響を受けそうだ。,,,,
status_apotheosis_brain_damage_02_name,Brain Rot,,,,,,,,重度脑部受损,脳障害,,,,
status_apotheosis_brain_damage_02_desc,The last of your neurons will soon cease to be.,,,,,,,,你最后的神经活动很快就会停止。,脳が破壊されていく。,,,,
status_apotheosis_brain_damage_perma_name,Brain Damage,,,,,,,,脑损伤,脳障害,,,,
status_apotheosis_brain_damage_perma_desc,You suffer permanent brain damage.\nAim is irreversibly disturbed.,,,,,,,,你受到了永久的脑损伤。\n瞄准受到不可逆的干扰。,脳機能に不可逆的な障害を負ってしまった。\n照準がうまく合わせられない。,,,,
status_apotheosis_flesh_curse_name,Sacrilegious Curse,,,,,,,,亵渎诅咒,涜神者の呪い,,,,
status_apotheosis_flesh_curse_desc,You feel your flesh growing uncontrollably.,,,,,,,,你感觉你的血肉在无法控制地生长。,身体から光がとめどなく溢れてくる！,,,,
status_apotheosis_flesh_curse_death,Corrupted.,,,,,,,,腐化,堕落,,,,
status_apotheosis_bragi_name,Poem of Seville,,,,,,,,塞维利亚之诗,セビリアの抒情詩,,,,
status_apotheosis_bragi_desc,You feel more fluent in spell casting!\nCast delay and reload time is significantly reduced on all wands.,,,,,,,,你感觉法术施放变得更加流畅！\n所有法杖的施放延迟和充能时间大大减少。,より滑らかに呪文を詠唱できるようになった！\n詠唱遅延、リチャージ時間が大きく減少する。,,,,
status_apotheosis_slow_name,Slow,Замедленное движение,Movimento lento,Movimiento lento,Langsamere Bewegungen,Mouvements réduits,Movimenti più lenti,Wolniejszy ruch,缓慢,移動速度低下,느린 이동,,,
status_apotheosis_slow_desc,You feel sluggish.,Вы некоторое время движетесь медленнее.,Sua movimentação se torna mais lenta por um tempo.,Te mueves más lento durante un tiempo.,Du bewegst dich eine Zeit lang langsamer.,Vous bougez plus lentement pendant un moment.,I tuoi movimenti sono rallentati per un certo periodo.,Przez jakiś czas poruszasz się wolniej.,你感觉慢吞吞的。,一定期間、移動速度が低下する。,잠시 동안 느리게 움직입니다.,,,
status_apotheosis_end_debuff_name,Final Requiem,,,,,,,,最后的镇魂曲,最後のレクイエム,,,,
status_apotheosis_end_debuff_desc,Protective Perks are disabled.\nYou can not be healed.,,,,,,,,令保护与免疫效果失效。\n此外，你无法受到治疗。,防御系パークの効果がなくなる。\n回復魔法の効果がない。,,,,
status_apotheosis_protection_vulnerable_name,Vulnerable Immunity,,,,,,,,虚弱免疫,無力感に対する免疫,,,,
status_apotheosis_protection_vulnerable_desc,You can not have your immunities disabled from most sources.,,,,,,,,你的保护与免疫效果不再会因大多数原因失效。,ほとんどの情報源から、プロテクト特典を無効にすることはできない。,,,,
creep_apotheosis_boss_flesh_monster_name,Kerettiläinenhirviö,,,,,,,,异端怪物,ケレッティレイネンヒルヴィオ,,,,
log_apotheosis_fish,The red fish is real,,,,,,,,朱红鱼是真实存在的,あかいさかな,,,,
log_apotheosis_shift_blocked_name,Shift Blocked,,,,,,,,转换受到了阻止,きのこシフトが無効化された,,,,
log_apotheosis_shift_blocked_desc,The world is set in stone.,,,,,,,,世界稳如磐石。,世界が進化の足を止めた。,,,,
log_apotheosis_upgrade_alwayscast_cheater_name,You cannot cheat the gods!,,,,,,,,你无法欺骗众神！,神の目は騙せない！,,,,
log_apotheosis_upgrade_alwayscast_cheater_desc,Always cast upgrade can only be used once,,,,,,,,始终施放升级只能使用一次,常時詠唱アップグレードは1度しか使えない。,,,,
log_apotheosis_upgrade_alwayscast_success_name,A permanent enchantment sinks into your wand,,,,,,,,一股永久的附魔浸入了你的法杖,杖に魔法のアップグレードが施された。,,,,
log_apotheosis_upgrade_alwayscast_success_desc,Some things can never be undone...,,,,,,,,覆水难收，有些事永远也不能反悔,元に戻せないものもある。,,,,
log_apotheosis_flesh_boss_warning,Something wicked this way comes...,,,,,,,,有邪恶的东西向这边走来...,異様な気配を感じる……,,,,
log_apotheosis_fishing_caught_name,You caught a fish!,,,,,,,,你钓到了一条鱼！,魚をゲットした！,,,,
log_apotheosis_fishing_caught_desc,Rarity:,,,,,,,,稀有度：,レア度:,,,,
item_apotheosis_egg_fire_lukki_name,Volcanic Egg,,,,,,,,火热的蛋,熱い卵,,,,
item_apotheosis_egg_fire_lukki_desc,It feels warm to the touch.\nYou feel it yerns for a new home.,,,,,,,,这个蛋摸起来非常温暖。\n你感觉它渴望一个新家。,触れると温かい卵。\n新たな巣を探しているようだ。,,,,
item_apotheosis_chest_death_cross,Deathly Chest,,,,,,,,死亡宝箱,死神のチェスト,,,,
item_apotheosis_egg_fairy_name,Glowing Egg,,,,,,,,发光的蛋,光る卵,,,,
item_apotheosis_egg_fairy_desc,The egg looks luminescent,,,,,,,,这个蛋看上去闪闪发光,光を放っている。,,,,
item_apotheosis_egg_robot_name,Robotic Egg,,,,,,,,机械的蛋,金属の卵,,,,
item_apotheosis_egg_robot_desc,The egg feels like it's moving,,,,,,,,这个蛋好像在动,今にも動き出しそうだ。,,,,
item_apotheosis_egg_mud_name,Muddy Egg,,,,,,,,泥泞的蛋,ドロドロの卵,,,,
item_apotheosis_egg_mud_desc,The egg feels amorphous,,,,,,,,这个蛋看上去形状不定,ドロドロしている。,,,,
item_apotheosis_money_1,Gold nugget (1),Золотой самородок (1),Pepita de ouro (1),Pepita de oro (1),Goldklumpen (1),Pépite d'or (1),Pepita d'oro (1),Grudka złota (1),金块 (1),金塊 (1),황금 덩어리(1),,,
item_apotheosis_bloodmoney_1,Bloody gold nugget (1),Кровавый золотой самородок (1),Pepita de ouro ensanguentada (1),Pepita de oro sangrienta (1),Blutiger Goldklumpen (1),Pépite d'or ensanglantée (1),Pepita d'oro insanguinata (1),Krwaw grudka złota (1),染血金块 (1),ブラッディー金塊 (1),피투성이 황금 덩어리(1),,,
item_apotheosis_heretical_eye_name,Heretical Eye,,,,,,,,异端之眼,ヘレティックアイ,,,,
item_apotheosis_heretical_eye_desc,It's watching you.,,,,,,,,它在看着你。,視線を感じる。,,,,
item_apotheosis_stone_heretic_name,Korruptoitunutkivi,,,,,,,,腐化石,コルップトイトゥヌトキヴィ,,,,
item_apotheosis_stone_heretic_desc,It feels drenched in blood.,,,,,,,,它被鲜血所覆盖。,血に染まっている。,,,,
item_apotheosis_stone_radar_name,Opastavakivi,,,,,,,,导引石,オパスタヴァキヴィ,,,,
item_apotheosis_stone_radar_desc,It pulses strangely.,,,,,,,,它在奇怪地震动。,謎の振動を感じる。,,,,
item_apotheosis_potion_reinforced_name,Large Potion,,,,,,,,大瓶魔药,メガポーション,,,,
item_apotheosis_potion_reinforced_name_with_material,Large $0 Potion,,,,,,,,大瓶$0魔药,$0 のメガポーション,,,,
item_apotheosis_orb_mattereater_name,Hungry Orb,Голодный шар,,,,,,,饥饿魔球,はらぺこオーブ,,,,
item_apotheosis_orb_mattereater_desc,"You feel the matter around it being sucked in. What happens if you kick it, you wonder...",,,,,,,,你感觉它在吸入周围的物质。你想试试踢它一下会怎么样...,周囲の物質が吸われている。蹴ったらどうなるのだろうか。,,,,
item_apotheosis_orb_affluence_name,Affluent Orb,,,,,,,,财富魔球,大富豪のオーブ,,,,
item_apotheosis_orb_affluence_desc,"You can see reflections of endless treasure within it. What happens if you kick it, you wonder...",,,,,,,,你能从它里面看到无尽宝藏的倒影。你想试试踢它一下会怎么样...,莫大な富が中に眠っていそうだ。蹴ったらどうなるのだろうか。,,,,
item_apotheosis_orb_cirno_name,Freezing Orb,,,,,,,,冰冻之球,カチコチオーブ,,,,
item_apotheosis_orb_cirno_desc,"Holding it makes you feel stupid. What happens if you kick it, you wonder...",,,,,,,,拿着它让你感觉自己很蠢。你想试试踢它一下会怎么样...,持ったらばかに感じさせる。蹴ったらどうなるだろうか。,,,,
item_apotheosis_fishing_rod_name,Fishing Rod,,,,,,,,钓鱼杆,釣り竿,,,,
item_apotheosis_fishing_rod_desc,Go fish..?\nLeft click to cast a line.\nLeft click again when a fish bites to reel it in.,,,,,,,,去钓鱼吧...？\n鼠标左键甩钩。\n当鱼咬钩再次左键收线。,釣り具だ。\n左クリックで仕掛けを投げる。\n魚が食いついたら、もう1度左クリック。,,,,
item_apotheosis_sampo_33_name,Heretical Knowledge,,,,,,,,异端恶理,異教の知識,,,,
item_apotheosis_sampo_34_name,Our Gift,,,,,,,,众神的恩赐,神の恩寵,,,,
item_apotheosis_runestone_alchemy_name,Runestone of Alchemy,,,,,,,,炼金之符石,錬金術師のルーンストーン,,,,
item_apotheosis_skill_angler_name,Angler Skill,,,,,,,,渔者的技能,釣り名人のギフト,,,,
item_apotheosis_skill_angler_desc,Increase your fishing skill level by 1.,,,,,,,,增加 1 级钓鱼技能等级,釣りレベルが1上昇する。,,,,
item_apotheosis_essence_polymorphine_name,Essence of Polymorphine...?,,,,,,,,变形之精粹...?,ポリモルフィンの……エッセンス？,,,,
item_apotheosis_essence_polymorphine_reveal_name,Essence of Polymorphine,,,,,,,,变形之精粹,ポリモルフィンのエッセンス,,,,
item_apotheosis_essence_polymorphine_desc,Wait...What?,,,,,,,,等等...什么？,これは一体何だ！？,,,,
item_apotheosis_stone_water_pink,Pink Vuoksikivi,,,,,,,,粉色水石,ピンッキヴォクシキヴィ,,,,
item_apotheosis_toiletpaper_fragment,Broken Spell of Cleanliness,,,,,,,,损坏的清洁法术,壊れた魔法（浄化）,,,,
item_apotheosis_toiletpaper_fragment_desc,"It looks broken, maybe it could be repaired?",,,,,,,,它看起来损坏了，或许可以去哪里修好它...,このままでは使えそうにない。修理することは可能だろうか？,,,,
sign_apotheosis_custom_seed,Custom Seed successfully set,,,,,,,,自定义种子设置成功,カスタムシードを取得した。,,,,
sign_apotheosis_divinity_hint_name,Sealed Note,,,,,,,,密封笔记,封印されたメモ,,,,
sign_apotheosis_divinity_hint_desc_00,"To those who seek knowledge not true, but divine.",,,,,,,,写给那些不寻求无瑕真理，而只对神圣至理求之若渴的人,真ならずも神聖なる智慧を追い求める者へ。,,,,
sign_apotheosis_divinity_hint_desc_01,One must have corruption purified by the gods.,,,,,,,,必须得到被众神净化的腐化物。,穢れた石は、神の手で浄化さるべし。,,,,
sign_apotheosis_divinity_hint_desc_02,One must not enter lands which do not contain our salt.,,,,,,,,必须远离不含吾等之盐的地方。,至高の宝なき地には入らぬべし。,,,,
sign_apotheosis_divinity_hint_desc_03,"One must offer that which brings excessive wealth, and the gate will come to life.",,,,,,,,必须提供能带来巨量财富之物，大门才会焕发生机。,至高の宝を門に捧げよ。さすれば門は開かれん。,,,,
sign_apotheosis_divinity_hint_desc_04,"One must hold Kingly knowledge for proper ascension, lest they ruin their form.",,,,,,,,必须持有王者的真理才能正确飞升，以免形态被毁。,より高き次元に登るは、諸王の智慧を持つ者のみ。,,,,
wand_apotheosis_deck_of_cards_name,Korttipakka,,,,,,,,牌堆,,,,DOESN'T NEED TO BE TRANSLATED,
wand_apotheosis_aimbot_name,Wand of Aiming,,,,,,,,自动魔杖,照準の杖,,,,
wand_apotheosis_rat_name,Rat,,,,,,,,老鼠,ロッタ,,,,
wand_apotheosis_cat_name,Cat,,,,,,,,猫咪,ねこ,,,,
wand_apotheosis_mana_battery_name,Mana Battery,,,,,,,,法力电池,マナバッテリー,,,,
wand_apotheosis_wand_of_wonders_name,Wand of Wonders,,,,,,,,妙想之杖,ワンダーワンド,,,,
damage_apotheosis_reverberation,Sound Waves,,,,,,,,声波,音波,,,,
damage_apotheosis_toxic_sphere,Toxic Sphere,,,,,,,,毒性巨球,猛毒スフィア,,,,
damage_apotheosis_addiction,Addiction,,,,,,,,成瘾,薬物,,,,
curse_apotheosis_yggdrasil_name,Yggdrasil's Curse,,,,,,,,世界树的诅咒,ユグドラシルの呪い,,,,
curse_apotheosis_yggdrasil_desc,You can no longer teleport.\nYou are unable to levitate.,,,,,,,,你无法传送或浮空。,飛行とテレポートが不可能になる。,,,,
curse_apotheosis_magic_name,Wild Magic Curse,,,,,,,,疯狂魔法诅咒,野生の呪い,,,,
curse_apotheosis_magic_desc,Your resistances and protective perks are disabled.,,,,,,,,你的抗性和免疫效果被禁用。,防御系パークの効果がなくなる。,,,,
curse_apotheosis_technology_name,Ground Zero,,,,,,,,爆心,グラウンドゼロ,,,,
curse_apotheosis_technology_desc,Experimental magic will periodically be detonated around your being.,,,,,,,,你的存在周围会周期性地引爆实验性魔法。,一部の魔法があなたの周囲で爆発するようになる。,,,,
curse_apotheosis_glassed_name,Glassed Curse,,,,,,,,玻璃化诅咒,ガラスの呪い,,,,
curse_apotheosis_glassed_desc,All creatures have glass cannon.,,,,,,,,所有生物都拥有玻璃大炮天赋。,全ての生物がガラスキャノンの効果を得る。,,,,
curse_apotheosis_hardcore_name,Hardcore,,,,,,,,硬核,ハードコア,,,,
curse_apotheosis_hardcore_desc,Healing Spells are uncopyable.\nMost enemies have additional health depending on the biome.\nSome creatures from late game biomes may have additional attack speed.\nMost bosses have significantly increased health.\nEnemies drop 50% less gold.\nAlt-Fire teleport bolt replaces normal teleport bolt.\nEnemies spawn 1 NG+ level earlier.,,,,,,,,"治疗法术不可被复制。\n大多数敌人根据所在群系获得额外生命值。\n游戏后期群系的一些敌人攻击速度增加。\n大大增加大多数 Boss 的生命值。\n敌人掉落的黄金减少 50%。\n""传送魔弹""被""副法术 - 传送魔弹""取代。\n敌人按照下一个 新游戏+ 的数值生成。",回復系スペルが複製不可になる。\n敵HPにバイオームに応じた補正が乗る。\n後半に登場する一部の敵は攻撃速度が上昇する。\nボスのHPが上昇する。\n敵がドロップするゴールドの量が半分になる。\nテレポートボルトがALT仕様になる。\n1つ先のNG+の敵が出現する。,,,,
curse_apotheosis_nightcore_name,Nightcore,,,,,,,,噩梦硬核,ルナティック,,,,
curse_apotheosis_nightcore_desc,Healing Spells are uncopyable.\nMost enemies have additional health depending on the biome.\nSome creatures from late game biomes may have additional attack speed.\nMost bosses have significantly increased health.\nEnemies drop 50% less gold.\nAlt-Fire teleport bolt replaces normal teleport bolt.\nEnemies spawn 1 NG+ level earlier.\nPlayer suffers from nightmare damage increases.,,,,,,,,"治疗法术不可被复制。\n大多数敌人根据所在群系获得额外生命值。\n游戏后期群系的一些敌人攻击速度增加。\n大大增加大多数 Boss 的生命值。\n敌人掉落的黄金减少 50%。\n""传送魔弹""被""副法术 - 传送魔弹""取代。\n敌人按照下一个 新游戏+ 的数值生成。\n此外，玩家还要承受噩梦模式的受到伤害加成。",回復系スペルが複製不可になる。\n敵HPにバイオームに応じた補正が乗る。\n後半に登場する一部の敵は攻撃速度が上昇する。\nボスのHPが上昇する。\n敵がドロップするゴールドの量が半分になる。\nテレポートボルトがALT仕様になる。\n1つ先のNG+の敵が出現する。\n受けるダメージにナイトメア補正が乗る。,,,,
curse_apotheosis_missingspells_name,Missing Spells,,,,,,,,缺法少术,魔法消滅,,,,
curse_apotheosis_missingspells_desc,Half of all spells are removed from reality.,,,,,,,,半数法术从现实中消失。,全魔法のうち半分が使えなくなる。,,,,
curse_apotheosis_towerclimb_name,Towerclimb,,,,,,,,爬塔,タワーの呪い,,,,
curse_apotheosis_towerclimb_desc,All biomes can spawn any creature.,,,,,,,,任何生物都可能在任何群系出现。,あらゆる敵が出現するようになる。,,,,
curse_apotheosis_alchemistdream_name,Alchemist's Dream,,,,,,,,炼金术士的梦想,錬金術師の夢,,,,
curse_apotheosis_alchemistdream_desc,All potions are replaced with Large Potions.\nAll liquid bubbles are blessed with glass cannon.\nAlchemists & Liquid bubble appear much more frequently.\nNew Liquid Bubbles appear.,,,,,,,,所有魔药替换为大瓶魔药。\n所有液体泡泡获得玻璃大炮天赋。\n席西炼金术士和液体泡泡出现的频率更高。\n出现新种类的液体泡泡。,全ポーションがメガポーションになる。\n泡系モブがガラスキャノンパークの効果を得る。\nアルケミスティと泡系の敵の出現頻度が上がる。\n新たな種類の泡系モブが出現する。,,,,
curse_apotheosis_addict_name,Addict,,,,,,,,瘾君子,薬物依存,,,,
curse_apotheosis_addict_desc,20 Fungal & Creature shifts occur at the start of the run.,,,,,,,,每局游戏开始时，会进行 20 次真菌转换和生物转换。,20個のシフト効果がゲーム開始時から発動する。,,,,
curse_apotheosis_poverty_name,Poverty,,,,,,,,一无所有,貧困,,,,
curse_apotheosis_poverty_desc,You're Affluen't\nMost enemies drop no gold.,,,,,,,,"你很""负有""。\n大多数敌人不再会掉落黄金。",ほとんどのモンスターは倒してもゴールドを落とさない。,,,,
curse_apotheosis_downunder_name,Down Under,,,,,,,,身在澳洲,逆さの呪い,,,,
curse_apotheosis_downunder_desc,The world is flipped upsidedown.\nBest of luck!,,,,,,,,世界上下颠倒。\n祝你好运！,世界が反転した。\nあなたに幸あらんことを！,,,,
curse_apotheosis_everything_name,Tuonela,,,,,,,,炼狱,トゥオネラ,,,,
curse_apotheosis_everything_desc,"All seeds are applied at once.\nEnemies drop significantly less gold.\nThe world is upsidedown.\nHardcore changes apply.\nNightcore damage increases apply.\nYou are blessed with additional health.\nYou can only win by Ascension, but are allowed to visit parallel worlds.\n\nThere is no escape.\nThere is no freedom.\nThis is your purgatory now.",,,,,,,,同时具有所有特殊种子的效果。\n敌人掉落的黄金大大减少。\n世界上下颠倒。\n具有硬核的所有特性。\n具有梦魇硬核的受到伤害加成。\n你受到额外生命值的祝福。\n你只能通过飞升取胜，但允许前往平行世界。\n\n插翅难飞，身不由己。\n现在，这就是你的炼狱。,すべての呪いが襲い来る。\n敵の落とすゴールドが激減。\n世界が上下反転する。\nハードコアモード補正が発生。\n受けるダメージがナイトメアモードと同じになる。\n神の恩寵でHPが増加する。\nクリア条件が変更。ただしパラレル世界に行くことは可。\n\n逃げ場のない地獄を、君は生き残れるか？,,,,
curse_apotheosis_weaken_name,Sunken Curse,,,,,,,,沉没诅咒,水底の呪い,,,,
curse_apotheosis_weaken_desc,Your resistances and protective perks are disabled.,,,,,,,,你的抗性和免疫效果被禁用。,防御系パークの効果がなくなる。,,,,
building_apotheosis_interact,Press $0 to undergo apotheosis.,,,,,,,,按 $0 接受神化。,$0 を押して効果を得る。,,,,
building_portal_interact,Press $0 to enter.,,,,,,,,按 $0 进入。,$0 を押して入る,,,,
building_portal_activate,Press $0 to complete the key.,,,,,,,,按 $0 完成关键。,$0 を押して鍵を完成させる。,,,,
building_portal_use,You feel you are no longer in the world you came from.,,,,,,,,你感觉你已经不在原来的世界中了,知らない世界に辿りついた。,,,,
credits_apotheosis_line_spoop,Various Enemy Sprites & Biome graphical design,,,,,,,,,,,,,
credits_apotheosis_line_sosig,Various Sprites for biome background & structures,,,,,,,,,,,,,
credits_apotheosis_line_20_new,"Helped with programming, creature design & mod direction",,,,,,,,,,,,,
credits_apotheosis_line_slack,Japanese Translator,,,,,,,,,,,,,
credits_apotheosis_line_extrahelp,And additional contributions from,,,,,,,,,,,,,
motd_apotheosis,Message of the Day,Сообщение дня,,,,,,,今日消息,今日のひとこと,,,,
motd_apotheosis_description,Message of the Day \nYou shouldn't be reading this.,Сообщение дня \nВы не должны были это прочесть.,,,,,,,今日消息\n你不应该看这个。,今日のひとこと\nここに メッセージは ないはずだよ\nみたら おしえてね,,,,
motd_apotheosis_description_birthday,Message of the Day \nHappy Birthday Apotheosis,"Сообщение дня \nПоздравлем с днём рождения, Apotheosis",,,,,,,今日消息\n生日快乐，Apotheosis 模组！,今日のひとこと\nリリース記念日！ハッピーバースデー！,,,,
motd_apotheosis_description_halloween,Message of the Day \nHappy Halloween!,Сообщение дня \nСчастливого Хэллоуина!,,,,,,,今日消息\n万圣节快乐！,今日のひとこと\nハッピーハロウィン！,,,,
motd_apotheosis_description_smissmass,Message of the Day \nHappy Noitmass!,Сообщение дня \nСчастливого Нойтждества!,,,,,,,"今日消息\n""诺诞节""快乐！",今日のひとこと\nnHappy Noitmass!,,,,
motd_apotheosis_description_new_year,"Happy new year! \nThankyou for playing, although you'll only read this once a year, I mean it every time you play. \nI'm happy seeing people enjoy my projects, and I'm happy making them myself, so sincerely, thankyou. - Conga Lyne.",,,,,,,,新年快乐！\n感谢你的游玩，虽然这条消息一年只能看到一次，我想说每分每秒我都在感激。\n我很开心看到大家享受我的作品，我也很开心自己做了这个项目，再一次真挚的，感谢你！ - Conga Lyne,,,,,
motd_apotheosis_description_red_fish,Message of the Day \nThe Red Fish is real.,,,,,,,,今日消息\n朱红鱼是真实存在的。,今日のひとこと\n赤いさかなはいます,,,,
motd_apotheosis_description_april_fools,Happy April Fools,Счастливого дня смеха,,,,,,,愚人节快乐,,エイプリルフール！,,,
motd_apotheosis_description_painpeko,Warning: Apotheosis is designed to be played on the Beta Branch of Noita.\nGame crashes may occur by playing on the main branch.\nYou can enable the Noita beta from steam via right-clicking Noita > Properties > Betas.,,,,,,,,警告：Apotheosis 设计在 Noita Beta 分支上运行。\n在正式版上游玩可能会发生游戏崩溃。\n你可以通过Steam右键Noita->属性->测试版来启用Noita Beta分支。,,,,,
motd_apotheosis_description_001,Message of the Day \nAlso try Worse Enemies!,Сообщение дня \nТакже попробуйте мод Worse Enemies!,,,,,,,今日消息\n也试试 Worse Enemies 模组！,今日のひとこと\nWorse Enemiesもプレイしてね。,,,,
motd_apotheosis_description_002,Message of the Day \nHomeless Hiisi love Material Donations,Сообщение дня \nБродяги любят пожертвования в виде денег,,,,,,,今日消息\n流浪席西爱心物资捐赠,今日のひとこと\n顔色が悪い人にお金をあげると、いいことがあるかも。,,,,
motd_apotheosis_description_003,Message of the Day \nBlood is Fuel.,Сообщение дня \nКровь - это топливо.,,,,,,,今日消息\n血是燃料。,今日のひとこと\n血は力なり。,,,,
motd_apotheosis_description_004,Message of the Day \nAlso try Copis Things!,Сообщение дня \nТакже попробуйте мод Copis Things!,,,,,,,今日消息\n也试试 Copis Things 模组！,今日のひとこと\n今日のおすすめMOD: Copis Things,,,,
motd_apotheosis_description_005,Message of the Day \nMeow. Meow. Meow. Meow. Meow.,Сообщение дня \nМяу. Мяу. Мяу. Мяу. Мяу.,,,,,,,今日消息\n喵~ 喵~ 喵~ 喵~ 喵~,今日のひとこと\nにゃーん,,,,
motd_apotheosis_description_006,Message of the Day \nGo outside.,,,,,,,,今日消息\n出去走走。,今日のひとこと\n外に出よう。,,,,
motd_apotheosis_description_007,Message of the Day \nApotheosis successfully initialised.,,,,,,,,今日消息\nApotheosis 模组启动成功。,今日のひとこと\nApotheosis Mod が インストールされました。,,,,
motd_apotheosis_description_008,Message of the Day \nHey? Can you hear me?! Get out while you still can!! HURRY.,"Сообщение дня \nЭй? Вы меня слышите?! Уходите, пока ещё не поздно!!! СКОРЕЕ.",,,,,,,今日消息\n嘿？能听到我说话吗？！趁现在还来得及！！快逃出去！！,今日のひとこと\nここは俺に任せろ、お前は先に行け！早く！,,,,
motd_apotheosis_description_009,Message of the Day \nAlso try Chemical Curiosities!,Сообщение дня \nТакже попробуйте мод Chemical Curiosities!,,,,,,,今日消息\n再试试满足化学的好奇心！,今日のひとこと\n今日のおすすめMOD: Chemical Curiosities,,,,
motd_apotheosis_description_010,Message of the Day \nEat crayons for divine knowledge.,,,,,,,,今日消息\n吃口蜡笔，你就能获取神圣至理。,今日のひとこと\nクレヨンを食べると、神々の智慧が得られるらしい。,,,,
motd_apotheosis_description_011,Message of the Day \nRemember to check your wand before firing!,,,,,,,,今日消息\n施法前记得检查你的魔杖！,今日のひとこと\nだから、撃つ前に杖の中身を確認する必要が、あったんですね(n敗),,,,
motd_apotheosis_description_012,Message of the Day \nI have 7 very important lore related questions.,,,,,,,,今日消息\n我有 7 个非常重要的传说相关问题。,今日のひとこと\n7つ、質問があります。このゲームの考察について。,,,,
motd_apotheosis_description_013,Message of the Day \nToday's magic numbers are: 78 40 28 59 20 13,,,,,,,,今日消息\n今天的魔法数字是：78 40 28 59 20 13,今日のラッキーナンバー\n78 40 28 59 20 13,,,,
motd_apotheosis_description_014,Message of the Day \nThis sign will never lie to you.\nEspecially about matters concerning fish.,,,,,,,,今日消息\n这个木牌从来不会骗你。\n尤其是关于鱼的。,今日のひとこと\nここに嘘は書いてないよ。ホントダヨ。魚とか。,,,,
motd_apotheosis_description_015,Message of the Day \nCan you hear ghosts? \nWithout assistance?,,,,,,,,今日消息\n你能听到鬼魂的声音吗？不借助任何东西的情况下？,今日のひとこと\n霊感はある？おばけは見える？,,,,
motd_apotheosis_description_016,Message of the Day \nThe struggle towards heights alone is enough to fill a man's heart,Сообщение дня \nМастера троллинга любят красные контуры. \nОни отлично впишутся,,,,,,,今日消息\n迈向高处的挣扎本身就足以填满一个人的心灵,今日のひとこと\n茶色い魔術師の線は赤の方がよかったかも。,,,,
motd_apotheosis_description_017,Message of the Day \nMusical Beings fear more than just stones....,"Сообщение дня \nМузыкальные существа боятся больше, чем просто камней....",,,,,,,今日消息\n音乐的存在惧怕的不仅仅是石头,今日のひとこと\n音楽系の敵に特殊な石を使うと……？,,,,
motd_apotheosis_description_018,Message of the Day \nKnowledge is scattered around the world.. find it.,Сообщение дня \nЗнания разбросаны по всему миру... найдите их.,,,,,,,今日消息\n真理散落在世界各地...去寻找吧,今日のひとこと\n隠し要素を探してみよう。,,,,
motd_apotheosis_description_019,"Message of the Day \nTry as you might, some creatures take all but a single chip from your attacks.",,,,,,,,今日消息\n尽你所能吧，有些生物只会承受你攻击伤害的九牛一毛。,今日のひとこと\n攻撃が通らない相手には、別の属性で攻めてみよう。,,,,
motd_apotheosis_description_020,Message of the Day \nIt's someone's birthday today! Happy Birthday!,,,,,,,,今日消息\n今天是某人的生日！生日快乐！,今日のひとこと\n今日も世界のどこかで新しい命が生まれています。ハッピーバースデー！,,,,
motd_apotheosis_description_021,Message of the Day \nRed sand is delicious!,,,,,,,,今日消息\n红砂很美味！,今日のひとこと\n赤い粉を食べてみると？,,,,
motd_apotheosis_description_022,"Message of the Day \nApotheosis, played by many, including yourself!",,,,,,,,今日消息\n很多人都玩过Apotheosis模组，包括你！,今日のひとこと\nApotheosis Modをプレイしていますか？\nはい いいえ,,,,
motd_apotheosis_description_023,Message of the Day \nPerhaps not every creep is a hostile. \nPerhaps not every crystal is a threat.,"Сообщение дня \nПожалуй, не каждый гад - враг. \Возможно, не каждый кристалл является угрозой.",,,,,,,今日消息\n也许并非每条蠕虫都是敌人。\n也许并非每个水晶都是威胁。,今日のひとこと\n敵じゃない生物もいるし、いい効果のクリスタルもあるかも。,,,,
motd_apotheosis_description_024,Message of the Day \nAlso try Conga's Cats!,,,,,,,,今日消息\n也试试 Conga's Cats 模组!,今日のひとこと\n今日のおすすめMOD: Conga's Cats,,,,
motd_apotheosis_description_025,"Message of the Day \nDescend into the drowning depths, the water awaits.",,,,,,,,今日消息\n潜入沉溺深渊，等着你的是水。,今日のひとこと\n沈んだ洞窟の先には、水の力が待つ。,,,,
motd_apotheosis_description_026,"Message of the Day \nGoodluck and have fun!. \nIf you're feeling frustrated or stressed, remember to take a break.","Сообщение дня \nУдачи и веселья! \nЕсли вы чувствуете разочарование или стресс, не забудьте сделать перерыв.",,,,,,,今日消息\n祝你好运，玩得开心！\n如果你感到沮丧或焦虑，记得休息一下。,今日のひとこと\nイライラしたり、疲れてきたら、ちょっと休憩を取ろう。,,,,
motd_apotheosis_description_027,Message of the Day \nI believe in you.,Сообщение дня \nЯ верю в вас.,,,,,,,今日消息\n我信任你。,今日のひとこと\nやればできる。,,,,
motd_apotheosis_description_028,Message of the Day \nFor a fun time: pour the densest liquid in the overgrowth,,,,,,,,今日消息\n取乐的好办法：将密度最大的液体倒入繁茂洞穴。,今日のひとこと\n最も重い液体を生い茂った洞窟で流すと……,,,,
motd_apotheosis_description_029,Message of the Day \nVenture into the desert. \nThere I will humour you.,,,,,,,,今日消息\n冒险进入沙漠吧。\n这样我就可以嘲笑你了。,今日のひとこと\n砂漠を探索してみよう。面白いものがあるかも？,,,,
motd_apotheosis_description_030,"Message of the Day \nHappy today! Good Now, be happy you're still here!","Сообщение дня \nСчастливый день! Счастливо, будьте счастливы, что вы ещё здесь!",,,,,,,今日消息\n天天开心！乐在当下，很高兴看到你还在这！,今日のひとこと\n今日はハッピーデー！生きててえらい！,,,,
motd_apotheosis_description_031,Message of the Day \nDon't visit the Toxic Worm Nest at 3 am.,Сообщение дня \nНе посещайте гнездо токсичных червей в 3 часа ночи.,,,,,,,今日消息\n不要在凌晨 3 点进入剧毒蠕虫巢穴。,今日のひとこと\n夜中の3時に行かない方がいい場所:毒虫の巣,,,,
motd_apotheosis_description_alt_001,Message of the Day \nAlso try Stray Pixel Cleanup!,,,,,,,,今日消息\n也试试 Stray Pixel Cleanup 模组！,今日のひとこと\n今日のおすすめMOD: Stray Pixel Cleanup,,,,
motd_apotheosis_description_alt_002,Message of the Day \nBe weary when travelling to other worlds.,,,,,,,,今日消息\n去其它世界时要保持警惕。,今日のひとこと\n異世界に行くときは注意しよう。,,,,
motd_apotheosis_description_alt_003,Message of the Day \nStay inside.,,,,,,,,今日消息\n待在里面别出来。,今日のひとこと\n今日は外に出ない方がいいかも。,,,,
motd_apotheosis_description_alt_004,Message of the Day \nDid you eat your powerballs today?,,,,,,,,今日消息\n你抽到想要的角色了吗？,今日のひとこと\nガチャは悪い文明,,,,
motd_apotheosis_description_alt_005,Message of the Day \nSour cream with Polish Sausage is delicious.,,,,,,,,今日消息\n酸奶油配波兰酱汁很好吃。,今日のひとこと\nキルバサソーセージ + サワークリーム = 神,,,,
motd_apotheosis_description_alt_006,Message of the Day \nEver have one of those days?,,,,,,,,今日消息\n以前有过这样的日子吗？,今日のひとこと\nツイてない日もある。,,,,
motd_apotheosis_description_alt_007,Message of the Day \nApotheosis\nMade by Conga & Friends.,,,,,,,,今日消息\nApotheosis\n由 Conga 和朋友们制作。,今日のひとこと\nこのMODはCongaとみんなの力で製作されています。,,,,
motd_apotheosis_description_alt_008,Message of the Day \nWelcome Back\nI'm sure your wand seemed more intuitive in the design docs.,,,,,,,,今日消息\n我很确定你的魔杖在设计文档里看上去更加直观。,今日のひとこと\nおかえりなさい！\nその杖、もしかして思ってたのと違う？,,,,
motd_apotheosis_description_alt_009,Message of the Day \nWan Wan!,,,,,,,,今日消息\n歪歪~！,今日のひとこと\nワンワン！,,,,
motd_apotheosis_description_alt_010,Message of the Day \nRobin was a fool.,,,,,,,,今日消息\n罗宾是个傻瓜。,今日のひとこと\n(翻訳できなかったネタ),,,,
motd_apotheosis_description_alt_011,Message of the Day \nBe honest with your feelings.\nBe honest with yourself.,,,,,,,,今日消息\n忠于你的感受。\n忠于你自己。,今日のひとこと\nフィーリングを信じよう。,,,,
motd_apotheosis_description_alt_012,"Message of the Day \nYou are not a clown, you are the entire circus.",,,,,,,,今日消息\n你不是小丑，你是一整个马戏团。,今日のひとこと\n俺自身がサーカスになることだ。,,,,
motd_apotheosis_description_alt_013,Message of the Day \nFriendship is a step on the path to success.,,,,,,,,今日消息\n友谊是通往成功道路上的一步。,今日のひとこと\n友情パワーは大事。,,,,
motd_apotheosis_description_alt_014,Message of the Day \nPortalium is my favourite liquid.\nWhat's yours?,,,,,,,,今日消息\n传送门魔药是我最喜欢的液体。\n你的是什么？,今日のひとこと\n作者のお気に入りはポータル液。キミはどう？,,,,
motd_apotheosis_description_alt_015,Message of the Day \nAlso try More Stuff!,,,,,,,,今日消息\n也试试 More Stuff 模组！,今日のひとこと\n今日のおすすめMOD: More Stuff,,,,
motd_apotheosis_description_alt_016,Message of the Day \n1432,,,,,,,,今日消息\n1432,今日のひとこと\n1432,,,,
motd_apotheosis_description_alt_017,"Message of the Day \nIf fighting is sure to result in victory,\nthen you must FIGHT!",,,,,,,,今日消息\n如果只要战斗就能取得胜利，\n那就必须战斗！,今日のひとこと\n勝てる戦いをしよう。,,,,
motd_apotheosis_description_alt_018,Message of the Day \nBlue fire doesn't always mean cold fire...,,,,,,,,今日消息\n火焰是蓝色的不代表它就是冷的...,今日のひとこと\n青い炎は冷たいわけじゃない。,,,,
motd_apotheosis_description_alt_019,Message of the Day \nBe careful of sewer mermaids.,,,,,,,,今日消息\n小心下水道人鱼。,今日のひとこと\nきたない人魚に気を付けよう,,,,
motd_apotheosis_description_alt_020,"Message of the Day \nHello, Deranged Maniac.",,,,,,,,今日消息\n你好，疯子。,今日のひとこと\nキミの常識、世界の非常識？,,,,
motd_apotheosis_description_alt_021,"Message of the Day \nApotheosis, founded 21/07/2022.",,,,,,,,今日消息\nApotheosis 模组始于2022年7月21日。,今日のひとこと\n22年7月21日は、このMODの誕生日。,,,,
motd_apotheosis_description_alt_022,Message of the Day \nThat chest is a spy!,,,,,,,,今日消息\n宝箱是间谍！,今日のひとこと\nそのチェストはニセモノ？,,,,
motd_apotheosis_description_alt_023,Message of the Day \nMagic Inebriation is ambivalently akin to Chaotic Transmutation.,,,,,,,,今日消息\n魔法紊乱与混乱转化有异曲同工之妙。,今日のひとこと\n「魔力のかく乱」はカオス変異とちょっと似てるかも？。,,,,
motd_apotheosis_description_alt_024,"Message of the Day \nAlways remember to eat healthy, you can't buy your health back.",,,,,,,,今日消息\n永远记住要健康饮食，再多的金钱也买不回健康。,今日のひとこと\nHPには気を付けよう。このゲームで回復はなかなかできない。,,,,
motd_apotheosis_description_alt_025,Message of the Day \nDo you remember games coming in boxes as a kid? \nIt was sick as hell having physical memorabilia.,,,,,,,,今日消息\n你还记得小时候装在盒子里的游戏吗？\n实实在在的纪念品真是棒极了。,今日のひとこと\nゲームが箱に入ってた頃って懐かしいよね。,,,,
motd_apotheosis_description_alt_026,Message of the Day \n3DS street pass was so damn cool. \nYou can still use it today if you know how.,,,,,,,,每日消息\n3DS的瞬缘连接真是酷毙了。\n如果你知道该怎么做，今天仍能使用它。,今日のひとこと\n「すれちがいMii広場」って楽しかったよね。\nまだ家に3DSはある？,,,,
motd_apotheosis_description_alt_027,Message of the Day \nRemember to exercise. \nHow about 5 pushups right now?,,,,,,,,今日消息\n要记得多锻炼。\n先来五个俯卧撑怎么样？,今日のひとこと\n運動は大事。今すぐやろう、とりあえず腕立て5回！,,,,
motd_apotheosis_description_alt_028,Message of the Day \nSome creatures drop loot extremely rarely. \nfeeling lucky?,,,,,,,,今日消息\n有些掉落物极其稀有。\n想试试吗？,今日のひとこと\nドロップアイテムがある敵もいる。出たらラッキーかも？,,,,
motd_apotheosis_description_alt_029,"Message of the Day \nThe dragon is an awesome boss, especially when he's draggon dez nuts.",,,,,,,,每日消息\n龙是一个可怕的Boss，尤其是当他发狂的时候。,今日のひとこと\n(翻訳不能なダジャレ),,,,
motd_apotheosis_description_alt_030,"Message of the Day \nThere's worms inside the walls who bare heavy armor. \nCareful not to awaken them unprepared, they're very hungry.",,,,,,,,今日消息\n墙壁内可能藏着一些身披重甲的虫子。\n当心不要毫无准备地吵醒它们，它们可都饿坏了。,今日のひとこと\nめちゃくちゃ硬いワームがいるから気を付けよう。\nすっごく強いぞ！,,,,
motd_apotheosis_description_alt_031,Message of the Day \nDon't visit the Toxic Worm Nest at 3 am.,Сообщение дня \nНе посещайте гнездо токсичных червей в 3 часа ночи.,,,,,,,今日消息\n不要在凌晨 3 点进入剧毒蠕虫巢穴。,今日のひとこと\n夜中の3時に行かない方がいい場所:毒虫の巣,,,,
enemy_apotheosis_abyssum_monster,Abyssaalinenolento,,,,,,,,深渊的存在,,,,DO NOT TRANSLATE,
enemy_apotheosis_angel,Jumalallinen olento,,,,,,,,神圣的存在,,,,DO NOT TRANSLATE,
enemy_apotheosis_ant_fire,Tulimurkku,,,,,,,,火焰蚁,,,,DO NOT TRANSLATE,
enemy_apotheosis_ant_pheromone,Sairaanhoitajamurkku,,,,,,,,护士蚁,,,,DO NOT TRANSLATE,
enemy_apotheosis_ant_suffocate,Tukahduttajamurkku,,,,,,,,窒息蚁,,,,DO NOT TRANSLATE,
enemy_apotheosis_barfer_greater_apotheosis,Suur-Turvonnu velho,,,,,,,,大型肿胀法师,,,,DO NOT TRANSLATE,
enemy_apotheosis_blindgazer,Sokeakatselija,,,,,,,,法球史莱姆,,,,DO NOT TRANSLATE,
enemy_apotheosis_blob_big,Isomöykky,,,,,,,,大斑点,,,,DO NOT TRANSLATE,
enemy_apotheosis_blob_huge,Kammottavamöykky,,,,,,,,巨大斑点,,,,DO NOT TRANSLATE,
enemy_apotheosis_blob_titan,Kolossaalimöykky,,,,,,,,终极斑点,,,,DO NOT TRANSLATE,
enemy_apotheosis_boss_musical_ghost,Hylättyorkesteri,,,,,,,,音乐幽灵,,,,DO NOT TRANSLATE,
enemy_apotheosis_boss_toxic_worm,Jättimäinenmyrkkymato,,,,,,,,剧毒蠕虫,,,,DO NOT TRANSLATE,
enemy_apotheosis_boss_toxic_worm_minion,Myrkyllinenmato,,,,,,,,毒虫爪牙,,,,DO NOT TRANSLATE,
enemy_apotheosis_boss_toxic_worm_parallel,Madon Muisti,,,,,,,,记忆蠕虫,,,,DO NOT TRANSLATE,
enemy_apotheosis_bubble_liquid,Nestemäinen kupla,,,,,,,,液体泡泡,,,,DO NOT TRANSLATE,
enemy_apotheosis_c_basebot_speeder_apotheosis,Johtaja,,,,,,,,加速巡逻机,,,,DO NOT TRANSLATE,
enemy_apotheosis_cat_mocreeps,Kissa,,,,,,,,猫,,,,DO NOT TRANSLATE,
enemy_apotheosis_cat_mocreeps_sorako,Sorako,,,,,,,,空子,,,,DO NOT TRANSLATE,
enemy_apotheosis_cat_mocreeps_sorako_esoteric,Esoteric Sorako,,,,,,,,神秘空子,,,,DO NOT TRANSLATE,
enemy_apotheosis_cat_mocreeps_louis,Louis,,,,,,,,路易斯,,,,DO NOT TRANSLATE,
enemy_apotheosis_cat_mocreeps_louis_gold,Golden Louis,,,,,,,,黄金路易斯,,,,DO NOT TRANSLATE,
enemy_apotheosis_cat_mocreeps_spoopy,Spoopy,,,,,,,,斯波比,,,,DO NOT TRANSLATE,
enemy_apotheosis_cat_mocreeps_spoopy_gold,Golden Spoopy,,,,,,,,黄金斯波比,,,,DO NOT TRANSLATE,
enemy_apotheosis_cat_mocreeps_herbet,Herbert,,,,,,,,赫伯特,,,,DO NOT TRANSLATE,
enemy_apotheosis_ccc_bat_psychic,Psyykkinenlepakko,,,,,,,,精神蝙蝠,,,,DO NOT TRANSLATE,
enemy_apotheosis_ceiling_fungus,Kattosieni,,,,,,,,倒吊真菌,,,,DO NOT TRANSLATE,
enemy_apotheosis_ceiling_fungus_minion,Pieni räjähtävä sieni,,,,,,,,小型爆炸真菌,,,,DO NOT TRANSLATE,
enemy_apotheosis_devourer_ghost,Nälkäinenaave,,,,,,,,吞噬鬼魂,,,,DO NOT TRANSLATE,
enemy_apotheosis_devourer_ghost_minion,Syömisen kirous,,,,,,,,吞噬咒体,,,,DO NOT TRANSLATE,
enemy_apotheosis_devourer_magic,Taikainen syöjä,,,,,,,,魔法吞噬者,,,,DO NOT TRANSLATE,
enemy_apotheosis_drone_mini,Pieni Lennokki,,,,,,,,小型无人机,,,,DO NOT TRANSLATE,
enemy_apotheosis_drone_status_ailment,Parannuskeinolennokki,,,,,,,,状态支援无人机,,,,DO NOT TRANSLATE,
enemy_apotheosis_enchanted_duck,Lumottu ankka,,,,,,,,魔力鸭子,,,,DO NOT TRANSLATE,
enemy_apotheosis_esoteric_being,Esoteerinenolento,,,,,,,,神秘的存在,,,,DO NOT TRANSLATE,
enemy_apotheosis_fairy,Keiju,,,,,,,,精灵,,,,DO NOT TRANSLATE,
enemy_apotheosis_fairy_big,Jättikeiju,,,,,,,,大精灵,,,,DO NOT TRANSLATE,
enemy_apotheosis_fairy_big_discord,Jättiristiriitakeiju,,,,,,,,失谐大精灵,,,,DO NOT TRANSLATE,
enemy_apotheosis_fairy_esoteric,Esoteerinenkeiju,,,,,,,,神秘精灵,,,,DO NOT TRANSLATE,
enemy_apotheosis_fairy_giant,Kolossaalinenkeiju,,,,,,,,巨大精灵,,,,DO NOT TRANSLATE,
enemy_apotheosis_fish_red,Punainenkala,,,,,,,,朱红鱼,,,,DO NOT TRANSLATE,
enemy_apotheosis_forest_monolith,Monoliitti,,,,,,,,一块巨石,,,,DO NOT TRANSLATE,
enemy_apotheosis_forsaken_eye,Hylättysilmä,,,,,,,,遗忘之眼,,,,DO NOT TRANSLATE,
enemy_apotheosis_fungus_smoking_creep,Savuavasieni,,,,,,,,冒烟真菌,,,,DO NOT TRANSLATE,
enemy_apotheosis_gazer_cold_apotheosis,Jäänkatse,,,,,,,,极寒凝视者,,,,DO NOT TRANSLATE,
enemy_apotheosis_gazer_greater,Suur-Helvetinkatse,,,,,,,,大型地狱凝视者,,,,DO NOT TRANSLATE,
enemy_apotheosis_gazer_greater_cold,Suur-Jäänkatse,,,,,,,,大型极寒凝视者,,,,DO NOT TRANSLATE,
enemy_apotheosis_gazer_greater_sky,Suur-Taivaankatse,,,,,,,,大型天空凝视者,,,,DO NOT TRANSLATE,
enemy_apotheosis_gazer_MVP,Jumalallinenjäänkatse,,,,,,,,神圣极寒凝视者,,,,DO NOT TRANSLATE,
enemy_apotheosis_gazer_parasitic,Parasiittinenkatse,,,,,,,,寄生凝视者,,,,DO NOT TRANSLATE,
enemy_apotheosis_gazer_robot,Aluebotti,,,,,,,,领域机器,,,,DO NOT TRANSLATE,
enemy_apotheosis_ghost_bow,Haamujousi,,,,,,,,幽灵弓,,,,DO NOT TRANSLATE,
enemy_apotheosis_giant_centipede,Nuori Tuhatjalkainen,,,,,,,,巨型蜈蚣,,,,DO NOT TRANSLATE,
enemy_apotheosis_goo_slug,Liimanetana,,,,,,,,粘胶蛞蝓,,,,DO NOT TRANSLATE,
enemy_apotheosis_hideous_mass,Hirvittävämassa,,,,,,,,狰狞乱肢,,,,DO NOT TRANSLATE,
enemy_apotheosis_hideous_mass_red,Hirvittäväliha,,,,,,,,狰狞肉团,,,,DO NOT TRANSLATE,
enemy_apotheosis_hiisi_chef_hell,Hornakokkihiisi,,,,,,,,地狱席西厨师,,,,DO NOT TRANSLATE,
enemy_apotheosis_hiisi_thief,Varashiisi,,,,,,,,席西窃贼,,,,DO NOT TRANSLATE,
enemy_apotheosis_hisii_engineer,Insinöörihiisi,,,,,,,,席西工程师,,,,DO NOT TRANSLATE,
enemy_apotheosis_hisii_giga_bomb,Psykopaattihiisi,,,,,,,,席西狂人,,,,DO NOT TRANSLATE,
enemy_apotheosis_hisii_hobo,Koditonhiisi,,,,,,,,席西乞丐,,,,DO NOT TRANSLATE,
enemy_apotheosis_hisii_hobo_rich,Rikashiisi,,,,,,,,席西富人,,,,DO NOT TRANSLATE,
enemy_apotheosis_hisii_clown,Klovni,,,,,,,,席西小丑,,,,DO NOT TRANSLATE,
enemy_apotheosis_hisii_minecart,Kaivoskärryhaulikkohiisi,,,,,,,,乘矿车的席西猎手,,,,DO NOT TRANSLATE,
enemy_apotheosis_hisii_minecart_tnt,Kaivoskärrytappurahaulikkohiisi,,,,,,,,乘矿车的席西矿工,,,,DO NOT TRANSLATE,
enemy_apotheosis_hisii_minecart_weak,Kaivoskärryhaulikkohiisi,,,,,,,,乘矿车的虚弱席西矿工,,,,DO NOT TRANSLATE,
enemy_apotheosis_hisii_rocketshotgun,Rakettihaulikkohiisi,,,,,,,,席西霰弹火箭手,,,,DO NOT TRANSLATE,
enemy_apotheosis_locust_swarm,Heinäsirkka,,,,,,,,蝗虫,,,,DO NOT TRANSLATE,
enemy_apotheosis_longleg_pillar,Kohoava Pilari-hämis,,,,,,,,小蜘蛛之柱,,,,DO NOT TRANSLATE,
enemy_apotheosis_lukki_fire_miniboss,Nuori Tulihämähäkki,,,,,,,,火焰蜘蛛幼虫,,,,DO NOT TRANSLATE,
enemy_apotheosis_lukki_fungus,Revitty sieni,,,,,,,,带根真菌,,,,DO NOT TRANSLATE,
enemy_apotheosis_lukki_swarmling,Nopealukki,,,,,,,,迅捷蜘蛛,,,,DO NOT TRANSLATE,
enemy_apotheosis_lukki_tentacle_hungry,Kirottuolento,,,,,,,,诅咒的存在,,,,DO NOT TRANSLATE,
enemy_apotheosis_mimic_explosive_box,Räjähdysherkkämatkija,,,,,,,,炸药箱拟态怪,,,,DO NOT TRANSLATE,
enemy_apotheosis_mimic_perk_twwe,Paskiainen,,,,,,,,天赋拟态怪,,,,DO NOT TRANSLATE,
enemy_apotheosis_miniboss_pit,Wandsin Arvostelija,,,,,,,,魔杖品鉴者,,,,DO NOT TRANSLATE,
enemy_apotheosis_mudman_friendly,Mutamies,,,,,,,,突变体,,,,DO NOT TRANSLATE,
enemy_apotheosis_musical_being,Kuulumaton,,,,,,,,希音,,,,DO NOT TRANSLATE,
enemy_apotheosis_musical_being_weak,Hiljainen,,,,,,,,寂音,,,,DO NOT TRANSLATE,
enemy_apotheosis_phantom_c_apotheosis,Pakkomielteinenkalma,,,,,,,,痴迷幻影,,,,DO NOT TRANSLATE,
enemy_apotheosis_poisonmushroom,Myrkyllinensieni,,,,,,,,毒蘑菇,,,,DO NOT TRANSLATE,
enemy_apotheosis_poring,Hyytelö,,,,,,,,凝胶,,,,DO NOT TRANSLATE,
enemy_apotheosis_poring_desert,Aavikkohyytelö,,,,,,,,沙漠凝胶,,,,DO NOT TRANSLATE,
enemy_apotheosis_poring_devil,Epäpyhähyytelö,,,,,,,,邪恶凝胶,,,,DO NOT TRANSLATE,
enemy_apotheosis_poring_holy,Jumalallinenhyytelö,,,,,,,,神圣凝胶,,,,DO NOT TRANSLATE,
enemy_apotheosis_poring_holy_arch,Korkeajumalallinenhyytelö,,,,,,,,大神圣凝胶,,,,DO NOT TRANSLATE,
enemy_apotheosis_poring_lukki,Lukkihyytelö,,,,,,,,蜘蛛凝胶,,,,DO NOT TRANSLATE,
enemy_apotheosis_poring_magic,Lumottuhyytelö,,,,,,,,魔法凝胶,,,,DO NOT TRANSLATE,
enemy_apotheosis_poring_swamp,Suohyytelö,,,,,,,,沼泽凝胶,,,,DO NOT TRANSLATE,
enemy_apotheosis_rat_birthday,Juhlarotta,,,,,,,,生日派对鼠,,,,DO NOT TRANSLATE,
enemy_apotheosis_seeker,Etsijä,,,,,,,,探索者,,,,DO NOT TRANSLATE,
enemy_apotheosis_sentry,Vartiomies,,,,,,,,哨兵,,,,DO NOT TRANSLATE,
enemy_apotheosis_shaman_greater_apotheosis,Suur-Märkiäinen,,,,,,,,大沼泽萨满,,,,DO NOT TRANSLATE,
enemy_apotheosis_slime_leaker,Vuotavajaska,,,,,,,,渗浆粘液怪,,,,DO NOT TRANSLATE,
enemy_apotheosis_slime_leaker_weak,Heikko Vuotavajaska,,,,,,,,虚弱渗浆粘液怪,,,,DO NOT TRANSLATE,
enemy_apotheosis_slime_teleporter,Säröilevä limanuljaska,,,,,,,,折跃粘液怪,,,,DO NOT TRANSLATE,
enemy_apotheosis_spirit_healing,Parantava-Aave,,,,,,,,治愈幽灵,,,,DO NOT TRANSLATE,
enemy_apotheosis_star_child,Tähtilapsi,,,,,,,,星之子,,,,DO NOT TRANSLATE,
enemy_apotheosis_sunken_creature,Sukelluskello,,,,,,,,潜钟,,,,DO NOT TRANSLATE,
enemy_apotheosis_tank_flame_apotheosis,Sytytystankki,,,,,,,,喷火坦克,,,,DO NOT TRANSLATE,
enemy_apotheosis_tentacler_big,Isoturso,,,,,,,,大触手怪,,,,DO NOT TRANSLATE,
enemy_apotheosis_tesla_turret,Teslatötterö,,,,,,,,特斯拉电塔,,,,DO NOT TRANSLATE,
enemy_apotheosis_tree_tall,Tall Tree,,,,,,,,高大的树,,,,DO NOT TRANSLATE,
enemy_apotheosis_triangle_gem,Kolmionmuotoinenkristalli,,,,,,,,三角水晶,,,,DO NOT TRANSLATE,
enemy_apotheosis_watermage,Vesimagi,,,,,,,,水魔,,,,DO NOT TRANSLATE,
enemy_apotheosis_watermage_greater,Suur-Vesimagi,,,,,,,,沝魔,,,,DO NOT TRANSLATE,
enemy_apotheosis_watermage_toxic,Myrkytetty Vesimagi,,,,,,,,剧毒水魔,,,,DO NOT TRANSLATE,
enemy_apotheosis_watermage_toxic_greater,Myrkytetty Suur-Vesimagi,,,,,,,,剧毒沝魔,,,,DO NOT TRANSLATE,
enemy_apotheosis_waterskull,Vesiö,,,,,,,,清水头颅,,,,DO NOT TRANSLATE,
enemy_apotheosis_whisp,Palavakeiju,,,,,,,,鬼火,,,,DO NOT TRANSLATE,
enemy_apotheosis_whisp_big,Jättipalavakeiju,,,,,,,,大鬼火,,,,DO NOT TRANSLATE,
enemy_apotheosis_whisp_giga,Kolossaalinenpalavakeiju,,,,,,,,巨大鬼火,,,,DO NOT TRANSLATE,
enemy_apotheosis_wizard_ambrosia,Kuolemattomuudenmestari,,,,,,,,不朽法师,,,,DO NOT TRANSLATE,
enemy_apotheosis_wizard_copeseethmald,Uistelunmestari,,,,,,,,引战法师,,,,DO NOT TRANSLATE,
enemy_apotheosis_wizard_corrupt_ambrosia,Korruptoitunut Kuolemattomuudenmestari,,,,,,,,腐化不朽法师,,,,DO NOT TRANSLATE,
enemy_apotheosis_wizard_corrupt_hearty,Korruptoitunut Haavoittajamestari,,,,,,,,腐化穿心法师,,,,DO NOT TRANSLATE,
enemy_apotheosis_wizard_corrupt_manaeater,Korruptoitunut Mananmestari,,,,,,,,腐化噬魔法师,,,,DO NOT TRANSLATE,
enemy_apotheosis_wizard_corrupt_neutral,Korruptoitunut Maadoittajamestari,,,,,,,,腐化中和法师,,,,DO NOT TRANSLATE,
enemy_apotheosis_wizard_corrupt_poly,Korruptoitunut Muodonmuutosmestari,,,,,,,,腐化变形法师,,,,DO NOT TRANSLATE,
enemy_apotheosis_wizard_corrupt_swapper,Korruptoitunut Vaihdosmestari,,,,,,,,腐化换位法师,,,,DO NOT TRANSLATE,
enemy_apotheosis_wizard_corrupt_teleport,Korruptoitunut Siirtäjämestari,,,,,,,,腐化传送法师,,,,DO NOT TRANSLATE,
enemy_apotheosis_wizard_corrupt_twitchy,Korruptoitunut Sätkymestari,,,,,,,,腐化抽搐法师,,,,DO NOT TRANSLATE,
enemy_apotheosis_wizard_corrupt_wands,Nukketeatterinmestari,,,,,,,,腐化傀儡法师,,,,DO NOT TRANSLATE,
enemy_apotheosis_wizard_corrupt_weaken,Korruptoitunut Turvattomuusmestari,,,,,,,,腐化削弱法师,,,,DO NOT TRANSLATE,
enemy_apotheosis_wizard_duck,Sinisorsienmestari,,,,,,,,唤鸭法师,,,,DO NOT TRANSLATE,
enemy_apotheosis_wizard_explosive,Räjähteidenmestari,,,,,,,,爆破法师,,,,DO NOT TRANSLATE,
enemy_apotheosis_wizard_firemage_greater,Suur-Stendari,,,,,,,,燚魔,,,,DO NOT TRANSLATE,
enemy_apotheosis_wizard_jackofalltrades,Eimitäänmestari,,,,,,,,无想法师,,,,DO NOT TRANSLATE,
enemy_apotheosis_wizard_manaeater,Mananmestari,,,,,,,,噬魔法师,,,,DO NOT TRANSLATE,
enemy_apotheosis_wizard_transmutation,Transmutaatioidenmestari,,,,,,,,异变法师,,,,DO NOT TRANSLATE,
enemy_apotheosis_wizard_z_poly_miniboss,Yli-innokas Muudonmuutosmestari,,,,,,,,狂热的变形法师,,,,DO NOT TRANSLATE,
enemy_apotheosis_worm_end_big_apotheosis,Suur-Helvetinmato,,,,,,,,巨型地狱蠕虫,,,,DO NOT TRANSLATE,
enemy_apotheosis_worm_esoteric,Esoteerinenmato,,,,,,,,神秘蠕虫,,,,DO NOT TRANSLATE,
enemy_apotheosis_worm_mechanical,Mekaaninenmato,,,,,,,,机械蠕虫,,,,DO NOT TRANSLATE,
enemy_apotheosis_worm_spine,Kirottuselkäranka,,,,,,,,诅咒遗骸,,,,DO NOT TRANSLATE,
enemy_apotheosis_worm_wall,Seinämato,,,,,,,,坚壁蠕虫,,,,DO NOT TRANSLATE,
enemy_apotheosis_wraith_alchemy_apotheosis,Alkeeminen Outo,,,,,,,,炼金怪异游魂,,,,DO NOT TRANSLATE,
enemy_apotheosis_wraith_returner_apotheosis,Heijastava Outo,,,,,,,,反制怪异游魂,,,,DO NOT TRANSLATE,
enemy_apotheosis_wraith_weirdo_shield,Outo,,,,,,,,怪异游魂,,,,DO NOT TRANSLATE,
enemy_apotheosis_blank,placeholder,,,,,,,,占位符,,,,DO NOT TRANSLATE,
]])

--Yggdrasil's Knowledge (The knowledge of life)
--
--Custom Spell Border for one-off spells would be sick
--
--Previous contact damage description
--perk_apotheosis_contactdamage_description,"You take no damage from close-range enemy attacks but enemies near you take damage; the damage is higher the lower your health gets.",,,,,,,,,,,,,




--Regular Spawns

ModLuaFileAppend("data/scripts/biomes/wizardcave.lua", "mods/Apotheosis/files/scripts/biomes/wizardcave_populator.lua")
ModLuaFileAppend("data/scripts/biomes/tower_end.lua", "mods/Apotheosis/files/scripts/biomes/tower_end_populator.lua")
ModLuaFileAppend("data/scripts/biomes/coalmine.lua", "mods/Apotheosis/files/scripts/biomes/coalmine_populator.lua")
ModLuaFileAppend("data/scripts/biomes/the_end.lua", "mods/Apotheosis/files/scripts/biomes/the_end_populator.lua")
ModLuaFileAppend("data/scripts/biomes/desert.lua", "mods/Apotheosis/files/scripts/biomes/desert_populator.lua")

ModLuaFileAppend("data/scripts/biomes/crypt.lua", "mods/Apotheosis/files/scripts/biomes/crypt_populator.lua")
ModLuaFileAppend("data/scripts/biomes/pyramid.lua", "mods/Apotheosis/files/scripts/biomes/pyramid_populator.lua")
ModLuaFileAppend("data/scripts/biomes/fungicave.lua", "mods/Apotheosis/files/scripts/biomes/fungicave_populator.lua")
ModLuaFileAppend("data/scripts/biomes/coalmine_alt.lua","mods/Apotheosis/files/scripts/biomes/coalmine_alt_populator.lua")
ModLuaFileAppend("data/scripts/biomes/pyramid_hallway.lua","mods/Apotheosis/files/scripts/biomes/pyramid_hallway_populator.lua")
ModLuaFileAppend("data/scripts/biomes/liquidcave.lua", "mods/Apotheosis/files/scripts/biomes/liquidcave_populator.lua")


ModLuaFileAppend("data/scripts/biomes/snowcastle_cavern.lua", "mods/Apotheosis/files/scripts/biomes/hiisi_shop_populator.lua")


ModLuaFileAppend("data/scripts/biomes/excavationsite.lua","mods/Apotheosis/files/scripts/biomes/excavationsite_populator.lua")
ModLuaFileAppend("data/scripts/biomes/vault_frozen.lua","mods/Apotheosis/files/scripts/biomes/vault_frozen_populator.lua")
ModLuaFileAppend("data/scripts/biomes/fungiforest.lua", "mods/Apotheosis/files/scripts/biomes/fungiforest_populator.lua")
ModLuaFileAppend("data/scripts/biomes/snowcastle.lua", "mods/Apotheosis/files/scripts/biomes/snowcastle_populator.lua")
ModLuaFileAppend("data/scripts/biomes/snowcave.lua", "mods/Apotheosis/files/scripts/biomes/snowcave_populator.lua")
ModLuaFileAppend("data/scripts/biomes/wandcave.lua", "mods/Apotheosis/files/scripts/biomes/wandcave_populator.lua")
ModLuaFileAppend("data/scripts/biomes/meat.lua", "mods/Apotheosis/files/scripts/biomes/meat_populator.lua")
ModLuaFileAppend("data/scripts/biomes/sandcave.lua", "mods/Apotheosis/files/scripts/biomes/sandcave_populator.lua")
ModLuaFileAppend("data/scripts/biomes/vault.lua", "mods/Apotheosis/files/scripts/biomes/vault_populator.lua")
--ModLuaFileAppend( "data/scripts/biomes/tower.lua", "mods/Apotheosis/files/scripts/biomes/tower_populator.lua" )
ModLuaFileAppend("data/scripts/biomes/rainforest.lua", "mods/Apotheosis/files/scripts/biomes/rainforest_populator.lua")   --Jungle
ModLuaFileAppend("data/scripts/biomes/rainforest_dark.lua","mods/Apotheosis/files/scripts/biomes/rainforest_dark_populator.lua")                                                 --Lukki Lair
ModLuaFileAppend("data/scripts/biomes/winter.lua", "mods/Apotheosis/files/scripts/biomes/winter_populator.lua")           --Snow Chasm
ModLuaFileAppend("data/scripts/biomes/clouds.lua", "mods/Apotheosis/files/scripts/biomes/clouds_populator.lua")           --Cloud Scape, for example coral chest area & essence of air area
ModLuaFileAppend("data/scripts/biomes/robobase.lua", "mods/Apotheosis/files/scripts/biomes/robobase_populator.lua")       --Power Plant
ModLuaFileAppend("data/scripts/biomes/lake_statue.lua", "mods/Apotheosis/files/scripts/biomes/lake_statue_populator.lua") --Lake Island
ModLuaFileAppend("data/scripts/biomes/hills.lua", "mods/Apotheosis/files/scripts/biomes/hills_populator.lua")             --Hills and shallow caves
ModLuaFileAppend("data/scripts/biomes/robot_egg.lua", "mods/Apotheosis/files/scripts/biomes/robot_egg_populator.lua")     --End of Everything Robotic Egg

--Not looking quite as good as the statues, might need a different art approach
--ModLuaFileAppend( "data/scripts/biomes/mountain_tree.lua", "mods/Apotheosis/files/scripts/biomes/mountain_tree_populator.lua" ) --Treechievements


ModLuaFileAppend("data/scripts/gun/gun_actions.lua", "mods/Apotheosis/files/actions.lua")

-- Could this be gsubbed?
ModLuaFileAppend("data/scripts/gun/gun.lua", "mods/Apotheosis/files/gun.lua")

dofile_once("mods/apotheosis/lib/injection.lua")

inject(args.StringFile, modes.PREPEND, "data/shaders/post_final.frag", "// liquid distortion",
	"mods/apotheosis/files/scripts/shader/trip_red_pre.frag")
inject(args.StringFile, modes.PREPEND, "data/shaders/post_final.frag", "gl_FragColor",
	"mods/apotheosis/files/scripts/shader/trip_red_post.frag")
inject(args.StringFile, modes.PREPEND, "data/shaders/post_final.frag", "varying vec2 tex_coord_fogofwar;",
	"mods/apotheosis/files/scripts/shader/trip_red_global.frag")

GameSetPostFxParameter("conga_red_sand_effect_amount", 0, 0, 0, 0)

--Appends Global Spawns to vanilla biome
do -- Global Spawns
	--DO NOT INCLUDE ANYTHING TOWER RELATED HERE, they're... "special" and need to be done in their own unique way
	for _, append in ipairs({
		{ -- General
			script = "global_populator",
			biomes = {
				"wizardcave", --Wizard's Den, aside from the darkness it's pretty habitable. Polymorph liquid is scarier, I can't shield that.
				"coalmine", --Coal Mine, first area, goodluck on your run
				"desert", --Desert above ground, careful not to die to any Stendari
				"crypt", --Temple of the Arts.. who died here?
				"pyramid", --Presumably everything below the entrance to the pyramid
				"fungicave", --BUNGUS!! cave, west side of area 2 for example
				"coalmine_alt", --Coalmine but to the west side near damp cave
				"pyramid_hallway", --Pyramid entrance, presumably
				"excavationsite", --Coal Pits, area 2
				"fungiforest", --Overgrowth
				"snowcave", --Snowy Depths
				"wandcave", --Magical temple.. huh
				"sandcave", --Desert sand cave, I don't think it includes desert chasm
				"winter", --Winter appears to be the snow chasm... terrifying. Also line 69!
				"rainforest", --Jungle
				"rainforest_dark", --Lukki Lair.. creepy
				"liquidcave", --Abandoned Alchemy Lab
			}
		},
		{ -- No Magic
			script = "global_populator_no_magic",
			biomes = {
				"the_end", --Heaven, or Hell, your choice. Either are The Work.
				"vault", --The Vault
				"robot_egg", --I'm sure you can guess
				"vault_frozen", --Like the vault, but way colder, worse, more hisii and with a really rude welcoming
				"snowcastle", --Hisii Base... Interesting name.. I won't judge.. too much, I've used some really weird inengine names myself in the past
				"robobase", --Power Plant
			}
		},
		{ -- Small Only
			script = "global_populator_smallonly",
			biomes = {
				"clouds", --Cloudscapes
				"hills", --Hills, aka forest.
			}
		},
	}) do
		-- Generate append script file path
		local appendpath = table.concat({ "mods/apotheosis/files/scripts/biomes/", append.script, ".lua" })
		-- Iterate over all biomes for the path
		for _, biome in ipairs(append.biomes) do
			-- Generate biome file path
			local biomepath = table.concat({ "data/scripts/biomes/", biome, ".lua" })
			-- Add the stuff
			ModLuaFileAppend(biomepath, appendpath)
		end
	end
end

--Appends Global Spawns to new biome files
do -- Global Spawns
	--DO NOT INCLUDE ANYTHING TOWER RELATED HERE, they're... "special" and need to be done in their own unique way
	for _, append in ipairs({
		{ -- General
			script = "global_populator",
			biomes = {
				"lava_excavation", --Core Mines, Volcanic lava filled land in the desert with plenty of loot but plenty of death
				"evil_temple", --Temple of Sacriligious Remains
			}
		},
	}) do
		-- Generate append script file path
		local appendpath = table.concat({ "mods/apotheosis/files/scripts/biomes/", append.script, ".lua" })
		-- Iterate over all biomes for the path
		for _, biome in ipairs(append.biomes) do
			-- Generate biome file path
			local biomepath = table.concat({ "mods/apotheosis/files/scripts/biomes/newbiome/", biome, ".lua" })
			-- Add the stuff
			ModLuaFileAppend(biomepath, appendpath)
		end
	end
end



--- Boss Spawns
--These use the Mountain Hall for biome compatibility.

--[[

--Spawns Toxic Worm boss after filling the dragon egg with toxic sludge
--This was the original intent, now the Toxic Worm spawns inside of a "nest" area of sorts with an egg, approach it and get got!
ModLuaFileAppend( "data/scripts/biomes/mountain/mountain_hall.lua", "mods/Apotheosis/files/scripts/biomes/boss_spawns/toxic_worm_nest_populator.lua" )


--Spawns the Abandoned Orchestra in the sandcaves.
ModLuaFileAppend( "data/scripts/biomes/mountain/mountain_hall.lua", "mods/Apotheosis/files/scripts/biomes/boss_spawns/boss_musical_ghost_sandcave_populator.lua" )


--Spawns a Magic Devourer inside the Abandoned Alchemy Lab to show off its' gimmick, only one though, and the only one with cell eater capabilities in the entire game!
ModLuaFileAppend( "data/scripts/biomes/mountain/mountain_hall.lua", "mods/Apotheosis/files/scripts/biomes/boss_spawns/devourer_magic_liquidcave_spawn.lua" )


--Spawns a wand editting crystal inside the pyramid, this will provide people incentive to go there and wander around the actual pyramid part for a bit before rushing either the boss or the orb.
ModLuaFileAppend( "data/scripts/biomes/mountain/mountain_hall.lua", "mods/Apotheosis/files/scripts/biomes/boss_spawns/pyramid_wandedit_crystal_populator.lua" )


--Deletes polymorph crystal surrounding the entrance to the Temple of the Art. Wouldn't want to get cockblocked by a poly crystal covering the entrance and a tentacler camping right behind the wall.
ModLuaFileAppend( "data/scripts/biomes/mountain/mountain_hall.lua", "mods/Apotheosis/files/scripts/biomes/boss_spawns/crypt_polycrystal_deletion_populator.lua" )


--Spawns a Hisii Beggar near the essence of earth, hopefully demonstrates or at least hints towards how to interact with them
ModLuaFileAppend( "data/scripts/biomes/mountain/mountain_hall.lua", "mods/Apotheosis/files/scripts/biomes/boss_spawns/hisii_beggar_populator.lua" )

]]
--


--Spawns all the above spawns in a single file and appends to pixel scenes to prevent double spawning
-- If Conjurer is enabled, disable this for a fix.
if ModIsEnabled("raksa") == false then
	dofile_once("mods/Apotheosis/files/scripts/biomes/boss_spawns/boss_spawn_list.lua")
	dofile_once("mods/Apotheosis/files/scripts/biomes/boss_spawns/blob_cave_spawn_list.lua")
end



--Spawns statues in the trophy room
--Deprecated, now down through a spawner w/ pixelscenes

--[[
if ModIsEnabled("purgatory") then
  ModLuaFileAppend( "data/scripts/biomes/mountain/mountain_hall.lua", "mods/Apotheosis/files/scripts/biomes/boss_spawns/purgatory/statue_room_populator.lua" )
else
  ModLuaFileAppend( "data/scripts/biomes/mountain/mountain_hall.lua", "mods/Apotheosis/files/scripts/biomes/boss_spawns/statue_room_populator.lua" )
end
]]
--





--Modded compatibility

--Alternate Biomes
--Remember to make specific files for these at some point.. it'd be weird if there were totally normal guys spawning in irridiated mines, or magical people in the robotics factory
if ModIsEnabled("biome-plus") then
	--Normal Spawns
	ModLuaFileAppend("data/scripts/biomes/mod/floodcave.lua","mods/Apotheosis/files/scripts/biomes/mod_compatibility/alt_biomes/aquifer_populator.lua")
	ModLuaFileAppend("data/scripts/biomes/mod/the_void.lua","mods/Apotheosis/files/scripts/biomes/mod_compatibility/alt_biomes/void_populator.lua")
	ModLuaFileAppend("data/scripts/biomes/mod/floating_mountain.lua","mods/Apotheosis/files/scripts/biomes/mod_compatibility/alt_biomes/floating_mountain_populator.lua")

	ModLuaFileAppend("data/scripts/biomes/mod/holy_temple.lua","mods/Apotheosis/files/scripts/biomes/crypt_populator.lua")
	ModLuaFileAppend("data/scripts/biomes/mod/collapsed_lab.lua","mods/Apotheosis/files/scripts/biomes/fungicave_populator.lua")
	ModLuaFileAppend("data/scripts/biomes/mod/irradiated_mines.lua",
		"mods/Apotheosis/files/scripts/biomes/coalmine_alt_populator.lua")

	ModLuaFileAppend("data/scripts/biomes/mod/blast_pit.lua","mods/Apotheosis/files/scripts/biomes/excavationsite_populator.lua")
	ModLuaFileAppend("data/scripts/biomes/mod/snowvillage.lua","mods/Apotheosis/files/scripts/biomes/mod_compatibility/alt_biomes/hisiivillage_populator.lua")
	ModLuaFileAppend("data/scripts/biomes/mod/frozen_passages.lua","mods/Apotheosis/files/scripts/biomes/snowcave_populator.lua")
	ModLuaFileAppend("data/scripts/biomes/mod/catacombs.lua","mods/Apotheosis/files/scripts/biomes/wandcave_populator.lua")
	ModLuaFileAppend("data/scripts/biomes/mod/tomb.lua", "mods/Apotheosis/files/scripts/biomes/sandcave_populator.lua")
	ModLuaFileAppend("data/scripts/biomes/mod/robofactory.lua","mods/Apotheosis/files/scripts/biomes/vault_populator.lua")
	ModLuaFileAppend("data/scripts/biomes/mod/swamp.lua","mods/Apotheosis/files/scripts/biomes/mod_compatibility/alt_biomes/swamp_populator.lua") --Jungle, could probably include bonus fungus here
	ModLuaFileAppend("data/scripts/biomes/mod/rainforest_wormy.lua","mods/Apotheosis/files/scripts/biomes/mod_compatibility/alt_biomes/wormtunnels_populator.lua")
	ModLuaFileAppend("data/scripts/biomes/mod/conduit.lua", "mods/Apotheosis/files/scripts/biomes/winter_populator.lua")
	ModLuaFileAppend("data/scripts/biomes/mod/sulfur_cave.lua","mods/Apotheosis/files/scripts/biomes/mod_compatibility/alt_biomes/hiddengrove_populator.lua") --Hidden Grove, Overgrowth populator

	--Global Spawns
	ModLuaFileAppend("data/scripts/biomes/mod/irradiated_mines.lua","mods/Apotheosis/files/scripts/biomes/global_populator.lua")
	ModLuaFileAppend("data/scripts/biomes/mod/blast_pit.lua", "mods/Apotheosis/files/scripts/biomes/global_populator.lua")
	ModLuaFileAppend("data/scripts/biomes/mod/frozen_passages.lua","mods/Apotheosis/files/scripts/biomes/global_populator.lua")
	ModLuaFileAppend("data/scripts/biomes/mod/the_void.lua", "mods/Apotheosis/files/scripts/biomes/global_populator.lua")
	ModLuaFileAppend("data/scripts/biomes/mod/collapsed_lab.lua","mods/Apotheosis/files/scripts/biomes/global_populator.lua")
	ModLuaFileAppend("data/scripts/biomes/mod/catacombs.lua", "mods/Apotheosis/files/scripts/biomes/global_populator.lua")
	ModLuaFileAppend("data/scripts/biomes/mod/swamp.lua", "mods/Apotheosis/files/scripts/biomes/global_populator.lua")
	ModLuaFileAppend("data/scripts/biomes/mod/robofactory.lua","mods/Apotheosis/files/scripts/biomes/global_populator_no_magic.lua")
	ModLuaFileAppend("data/scripts/biomes/mod/holy_temple.lua","mods/Apotheosis/files/scripts/biomes/global_populator.lua")
	ModLuaFileAppend("data/scripts/biomes/mod/snowvillage.lua","mods/Apotheosis/files/scripts/biomes/global_populator.lua")
	ModLuaFileAppend("data/scripts/biomes/mod/tomb.lua", "mods/Apotheosis/files/scripts/biomes/global_populator.lua")
	ModLuaFileAppend("data/scripts/biomes/mod/rainforest_wormy.lua","mods/Apotheosis/files/scripts/biomes/global_populator.lua")
	ModLuaFileAppend("data/scripts/biomes/mod/conduit.lua", "mods/Apotheosis/files/scripts/biomes/global_populator.lua")
	ModLuaFileAppend("data/scripts/biomes/mod/sulfur_cave.lua","mods/Apotheosis/files/scripts/biomes/global_populator.lua")

	--Dark Areas
	ModLuaFileAppend("data/scripts/biomes/mod/irradiated_mines.lua","mods/Apotheosis/files/scripts/biomes/suspicious.lua")
	ModLuaFileAppend("data/scripts/biomes/mod/tomb.lua", "mods/Apotheosis/files/scripts/biomes/suspicious.lua")
	ModLuaFileAppend("data/scripts/biomes/mod/conduit.lua", "mods/Apotheosis/files/scripts/biomes/suspicious.lua")
	ModLuaFileAppend("data/scripts/biomes/mod/the_void.lua", "mods/Apotheosis/files/scripts/biomes/suspicious.lua")
end


--New Enemies, boosts ghost spawnrate in sandcave so they aren't flushed out by the quantity of other creatures.
--Also boosts Divine Being & Divine Poring spawnrates in Heaven & Hell for unlocks
if ModIsEnabled("new_enemies") then
	ModLuaFileAppend("data/scripts/biomes/sandcave.lua", "mods/Apotheosis/files/scripts/biomes/mod_compatibility/sandcave_ghostbooster_populator.lua")
	--ModLuaFileAppend( "data/scripts/biomes/the_end.lua", "mods/Apotheosis/files/scripts/biomes/mod_compatibility/the_end_angelboost_populator.lua" )
end

--New Enemies, boosts ghost spawnrate in sandcave so they aren't flushed out by the quantity of other creatures, compatibility for alt biomes.
if ModIsEnabled("new_enemies") then
	if ModIsEnabled("biome-plus") then
		ModLuaFileAppend("data/scripts/biomes/mod/tomb.lua", "mods/Apotheosis/files/scripts/biomes/mod_compatibility/sandcave_ghostbooster_populator.lua")
	end
end




-- Conjurer Mod, adds enemies, buildings and wands to a custom tab
if ModIsEnabled("raksa") then
	ModLuaFileAppend("mods/raksa/files/scripts/lists/entity_categories.lua", "mods/Apotheosis/files/scripts/mod_compatibility/conjurer_populator.lua")
end



--Worse Enemies, Overrides Hisii Minecart visuals & attacks to match those from the mod
if ModIsEnabled("worse_enemies") then
	local nxml = dofile_once("mods/Apotheosis/lib/nxml.lua")
	local content = ModTextFileGetContent("data/entities/animals/hisii_minecart_tnt.xml")
	local xml = nxml.parse(content)
	xml:first_of("Base"):first_of("SpriteComponent").attr.image_file =
	"mods/Apotheosis/files/enemies_gfx/hisii_minecart_worse_tnt.xml"
	xml:first_of("Base"):first_of("AnimalAIComponent").attr.attack_ranged_entity_file =
	"data/entities/projectiles/cocktail_gunpowder.xml"
	ModTextFileSetContent("data/entities/animals/hisii_minecart_tnt.xml", tostring(xml))

	local content = ModTextFileGetContent("data/entities/animals/hisii_minecart.xml")
	local xml = nxml.parse(content)
	xml:first_of("Base"):first_of("SpriteComponent").attr.image_file =
	"mods/Apotheosis/files/enemies_gfx/hisii_minecart_worse.xml"
	xml:first_of("Base"):first_of("AnimalAIComponent").attr.attack_ranged_entity_file =
	"data/entities/projectiles/meteor_green.xml"
	xml:first_of("Base"):first_of("DamageModelComponent").attr.hp = "1.0"
	xml:add_child(nxml.parse([[
    <SpriteComponent
      _tags="character"
      image_file="mods/Apotheosis/files/enemies_gfx/hisii_minecart_worse_emissive.xml"
      offset_x="0"
      offset_y="0"
      alpha="1"
      emissive="1"
      additive="1">
	</SpriteComponent>
  ]]))
	ModTextFileSetContent("data/entities/animals/hisii_minecart.xml", tostring(xml))

	local content = ModTextFileGetContent("data/entities/animals/hisii_minecart_weak.xml")
	local xml = nxml.parse(content)
	xml:first_of("Base"):first_of("SpriteComponent").attr.image_file =
	"mods/Apotheosis/files/enemies_gfx/hisii_minecart_worse_weak.xml"
	xml:first_of("Base"):first_of("AnimalAIComponent").attr.attack_ranged_entity_file =
	"data/entities/projectiles/fireball_buckshot.xml"
	ModTextFileSetContent("data/entities/animals/hisii_minecart_weak.xml", tostring(xml))

	--Bat Illusion Fix
	local content = ModTextFileGetContent("data/entities/animals/psychotic/bat.xml")
	local xml = nxml.parse(content)
	xml:first_of("Base"):first_of("SpriteComponent").attr.image_file = "data/enemies_gfx/worse/bat.xml"
	ModTextFileSetContent("data/entities/animals/psychotic/bat.xml", tostring(xml))

	--Illusion Shotgunner Hisii Fix
	local content = ModTextFileGetContent("data/entities/animals/psychotic/shotgunner.xml")
	local xml = nxml.parse(content)
	xml:first_of("Base"):first_of("AnimalAIComponent").attr.attack_ranged_entity_file =
	"mods/Apotheosis/files/entities/projectiles/psychotic/meteor_green.xml"
	ModTextFileSetContent("data/entities/animals/psychotic/shotgunner.xml", tostring(xml))
end

-- Noita Toether compatibility, allows items like the new tablets, Fungus Stone & Hungry Orb to be added to the item bank
--This is done... weirdly
--[[
if ModIsEnabled("noita-together") then
  ModLuaFileAppend( "mods/noita-together/files/scripts/item_list.lua", "mods/Apotheosis/files/scripts/mod_compatibility/nt_itemlist_populator.lua" )
end
]]
--




-- Custom Perk support injection
ModLuaFileAppend("data/scripts/perks/perk_list.lua", "mods/Apotheosis/files/scripts/perks/custom_perks.lua")


-- Custom Status support injection
ModLuaFileAppend("data/scripts/status_effects/status_list.lua",
	"mods/Apotheosis/files/scripts/status_effects/status_effects.lua")


-- Custom Audio Support
ModRegisterAudioEventMappings("mods/Apotheosis/files/audio/GUIDs.txt")



-- Misc

--Twitch Integration
--01/01/2023 Conga: I will only add creature shifting as an event as it's functionality is exclusive to Apotheosis.
ModLuaFileAppend( "data/scripts/streaming_integration/event_list.lua", "mods/Apotheosis/files/scripts/streaming_integration/event_list_populator_apoth.lua" )


--Musicstone tag addition
dofile_once("mods/Apotheosis/files/scripts/magic/music_magic_tag_nxml.lua")

if HasFlagPersistent("action_apotheosis_aqua_mine") or HasFlagPersistent("action_apotheosis_bomb_giga") then
	AddFlagPersistent("apotheosis_card_unlocked_welcome_hint")
end

--MOTD & Welcome Hint
if ModIsEnabled("raksa") == false then
	local flag_status = HasFlagPersistent("apotheosis_card_unlocked_welcome_hint")
	if motdSetting == true or ((month == 4) and (day == 1)) then
		dofile_once("mods/Apotheosis/files/scripts/misc/motd_list.lua")
	elseif flag_status == false then
		--dofile_once( "mods/Apotheosis/files/scripts/misc/welcome_hint.lua" )
	end
end

--Allows hisii to jump into minecarts
local nxml = dofile_once("mods/Apotheosis/lib/nxml.lua")
if ModIsEnabled("Ride Minecart") == false then
	local content = ModTextFileGetContent("data/entities/props/physics_minecart.xml")
	local xml = nxml.parse(content)
	xml.attr.name = "minecart_hisii_hopin"
	ModTextFileSetContent("data/entities/props/physics_minecart.xml", tostring(xml))
	ModTextFileSetContent("data/entities/props/physics/minecart.xml", tostring(xml))
end

--local content = ModTextFileGetContent("data/entities/props/physics/minecart.xml")
--local xml = nxml.parse(content)
--xml.attr.name = "minecart_hisii_hopin"
--ModTextFileSetContent("data/entities/props/physics/minecart.xml", tostring(xml))


--Same thing but for hisii
local content = ModTextFileGetContent("data/entities/animals/shotgunner.xml")
local xml = nxml.parse(content)
xml:add_child(nxml.parse([[
    <LuaComponent
        script_source_file="mods/Apotheosis/files/scripts/buildings/hisii_minecart_hopin.lua"
        execute_every_n_frame="60"
        >
    </LuaComponent>
]]))
ModTextFileSetContent("data/entities/animals/shotgunner.xml", tostring(xml))

--Same thing but for hisii with TNT
local content = ModTextFileGetContent("data/entities/animals/miner_weak.xml")
local xml = nxml.parse(content)
xml:add_child(nxml.parse([[
    <LuaComponent
        script_source_file="mods/Apotheosis/files/scripts/buildings/hisii_minecart_hopin_tnt.lua"
        execute_every_n_frame="60"
        >
    </LuaComponent>
]]))
ModTextFileSetContent("data/entities/animals/miner_weak.xml", tostring(xml))



-- Stendari magic wetness fix
local content = ModTextFileGetContent("data/entities/animals/firemage.xml")
local xml = nxml.parse(content)
local attrs = xml:first_of("Base"):first_of("DamageModelComponent").attr
attrs.materials_that_damage = attrs.materials_that_damage .. ",water_fading"
attrs.materials_how_much_damage = attrs.materials_how_much_damage .. ",0.0005"
ModTextFileSetContent("data/entities/animals/firemage.xml", tostring(xml))

-- Gazer magic wetness fix
local content = ModTextFileGetContent("data/entities/animals/gazer.xml")
local xml = nxml.parse(content)
local attrs = xml:first_of("Base"):first_of("DamageModelComponent").attr
attrs.materials_that_damage = attrs.materials_that_damage .. ",water,water_fading"
attrs.materials_how_much_damage = attrs.materials_how_much_damage .. ",0.0005,0.0005"
ModTextFileSetContent("data/entities/animals/gazer.xml", tostring(xml))

-- Burning Skull magic wetness fix
local content = ModTextFileGetContent("data/entities/animals/fireskull.xml")
local xml = nxml.parse(content)
local attrs = xml:first_of("Base"):first_of("DamageModelComponent").attr
attrs.materials_that_damage = attrs.materials_that_damage .. ",water_fading"
attrs.materials_how_much_damage = attrs.materials_how_much_damage .. ",0.0005"
ModTextFileSetContent("data/entities/animals/fireskull.xml", tostring(xml))

-- Spit Monster magic wetness fix
local content = ModTextFileGetContent("data/entities/animals/spitmonster.xml")
local xml = nxml.parse(content)
local attrs = xml:first_of("Base"):first_of("DamageModelComponent").attr
attrs.materials_that_damage = attrs.materials_that_damage .. ",water,water_fading"
attrs.materials_how_much_damage = attrs.materials_how_much_damage .. ",0.0005,0.0005"
ModTextFileSetContent("data/entities/animals/spitmonster.xml", tostring(xml))

--Allows for essence of fungus to be turned into a stone
local content = ModTextFileGetContent("data/entities/buildings/essence_eater.xml")
local xml = nxml.parse(content)
xml:add_child(nxml.parse([[
	<LuaComponent
		execute_every_n_frame="-1"
		script_death="mods/Apotheosis/files/scripts/essence/away_modded.lua"
		remove_after_executed="0"
		>
	</LuaComponent>
]]))
ModTextFileSetContent("data/entities/buildings/essence_eater.xml", tostring(xml))

--Allows for moon shenanigans involving essences at the Sky Moon
local content = ModTextFileGetContent("data/entities/buildings/moon_altar.xml")
local xml = nxml.parse(content)
xml:add_child(nxml.parse([[
	<LuaComponent
    _enabled="1"
    execute_every_n_frame="70"
    script_source_file="mods/Apotheosis/files/scripts/magic/moon_altar_modded.lua"
    >
  </LuaComponent>
]]))
ModTextFileSetContent("data/entities/buildings/moon_altar.xml", tostring(xml))

--Allows for moon shenanigans involving essences at the Dark Moon
local content = ModTextFileGetContent("data/entities/buildings/dark_moon_altar.xml")
local xml = nxml.parse(content)
xml:add_child(nxml.parse([[
	<LuaComponent
    _enabled="1"
    execute_every_n_frame="70"
    script_source_file="mods/Apotheosis/files/scripts/magic/dark_moon_altar_modded.lua"
    >
  </LuaComponent>
]]))
ModTextFileSetContent("data/entities/buildings/dark_moon_altar.xml", tostring(xml))



--Nightmare & Purgatory fixes for bubbles so they don't spew out infinite liquid everywhere
--I forgot nightmare/purgatory naturally reduces blood multipliers by default anyways.. oops
--[[
if ModIsEnabled("purgatory") or ModIsEnabled("nightmare") then

  local nxml = dofile_once("mods/Apotheosis/lib/nxml.lua")
  local content = ModTextFileGetContent("data/entities/animals/bubble_liquid.xml")
  local xml = nxml.parse(content)
  local attrs = xml:first_of("Base"):first_of("DamageModelComponent").attr
  attrs.blood_multiplier = "20"
  ModTextFileSetContent("data/entities/animals/bubble_liquid.xml", tostring(xml))

  local nxml = dofile_once("mods/Apotheosis/lib/nxml.lua")
  local content = ModTextFileGetContent("data/entities/animals/bubbles/acid/bubble_liquid.xml")
  local xml = nxml.parse(content)
  local attrs = xml:first_of("Base"):first_of("DamageModelComponent").attr
  attrs.blood_multiplier = "20"
  ModTextFileSetContent("data/entities/animals/bubbles/acid/bubble_liquid.xml", tostring(xml))

  local content = ModTextFileGetContent("data/entities/animals/bubbles/freezing_liquid/bubble_liquid.xml")
  local xml = nxml.parse(content)
  local attrs = xml:first_of("Base"):first_of("DamageModelComponent").attr
  attrs.blood_multiplier = "30"
  ModTextFileSetContent("data/entities/animals/bubbles/freezing_liquid/bubble_liquid.xml", tostring(xml))

  local content = ModTextFileGetContent("data/entities/animals/bubbles/cursed_liquid/bubble_liquid.xml")
  local xml = nxml.parse(content)
  local attrs = xml:first_of("Base"):first_of("DamageModelComponent").attr
  attrs.blood_multiplier = "10"
  ModTextFileSetContent("data/entities/animals/bubbles/cursed_liquid/bubble_liquid.xml", tostring(xml))

  local content = ModTextFileGetContent("data/entities/animals/bubbles/ambrosia/bubble_liquid.xml")
  local xml = nxml.parse(content)
  local attrs = xml:first_of("Base"):first_of("DamageModelComponent").attr
  attrs.blood_multiplier = "20"
  ModTextFileSetContent("data/entities/animals/bubbles/ambrosia/bubble_liquid.xml", tostring(xml))

  local content = ModTextFileGetContent("data/entities/animals/bubbles/alchemicprecursor/bubble_liquid.xml")
  local xml = nxml.parse(content)
  local attrs = xml:first_of("Base"):first_of("DamageModelComponent").attr
  attrs.blood_multiplier = "15"
  ModTextFileSetContent("data/entities/animals/bubbles/alchemicprecursor/bubble_liquid.xml", tostring(xml))

  local content = ModTextFileGetContent("data/entities/animals/bubbles/healthium/bubble_liquid.xml")
  local xml = nxml.parse(content)
  local attrs = xml:first_of("Base"):first_of("DamageModelComponent").attr
  attrs.blood_multiplier = "15"
  ModTextFileSetContent("data/entities/animals/bubbles/healthium/bubble_liquid.xml", tostring(xml))

  local content = ModTextFileGetContent("data/entities/animals/bubbles/unstablePandorium/bubble_liquid.xml")
  local xml = nxml.parse(content)
  local attrs = xml:first_of("Base"):first_of("DamageModelComponent").attr
  attrs.blood_multiplier = "10"
  ModTextFileSetContent("data/entities/animals/bubbles/unstablePandorium/bubble_liquid.xml", tostring(xml))

  local content = ModTextFileGetContent("data/entities/animals/bubbles/pandorium/bubble_liquid.xml")
  local xml = nxml.parse(content)
  local attrs = xml:first_of("Base"):first_of("DamageModelComponent").attr
  attrs.blood_multiplier = "10"
  ModTextFileSetContent("data/entities/animals/bubbles/pandorium/bubble_liquid.xml", tostring(xml))

  local content = ModTextFileGetContent("data/entities/animals/bubbles/stophittingyourself/bubble_liquid.xml")
  local xml = nxml.parse(content)
  local attrs = xml:first_of("Base"):first_of("DamageModelComponent").attr
  attrs.blood_multiplier = "10"
  ModTextFileSetContent("data/entities/animals/bubbles/stophittingyourself/bubble_liquid.xml", tostring(xml))

  local content = ModTextFileGetContent("data/entities/animals/bubbles/sliceLiquid/bubble_liquid.xml")
  local xml = nxml.parse(content)
  local attrs = xml:first_of("Base"):first_of("DamageModelComponent").attr
  attrs.blood_multiplier = "10"
  ModTextFileSetContent("data/entities/animals/bubbles/sliceLiquid/bubble_liquid.xml", tostring(xml))

end
]]
--

--Resets Blob Boss kill reward to prevent cheesing multiple "reward events" per kill
ModLuaFileAppend("data/scripts/newgame_plus.lua", "mods/Apotheosis/files/scripts/newgame_plus_appends.lua")
--GameRemoveFlagRun( "apotheosis_blob_boss_slain" )

--Adds custom enlightened alchemist types
--Could instead have a script that has a 2 in 6 chance to occur, and if it does make the alchemist one of the new variants, and append all this as a script on the englightened alch entity that runs after the vanilla init occurs
local content = ModTextFileGetContent("mods/Apotheosis/files/scripts/mod_compatibility/vanilla_enlightened_alchemist_init_append.lua")
ModTextFileSetContent("data/scripts/animals/enlightened_alchemist_init.lua", tostring(content))
--ModLuaFileAppend( "data/scripts/animals/enlightened_alchemist_init.lua", "mods/Apotheosis/files/scripts/mod_compatibility/vanilla_enlightened_alchemist_init_append.lua" )

-- Adds musical_stone tag to the worm projectile, not to make musical ghosts appear but rather to make it double for a "spells to worms" effect
local content = ModTextFileGetContent("data/entities/projectiles/deck/worm_shot.xml")
local xml = nxml.parse(content)
xml.attr.tags = xml.attr.tags .. ",musical_stone"
ModTextFileSetContent("data/entities/projectiles/deck/worm_shot.xml", tostring(xml))

-- Adds various powders to dissolve powders perk
local content = ModTextFileGetContent("data/entities/misc/perks/dissolve_powders.xml")
local xml = nxml.parse(content)
local attrs = xml:first_of("CellEaterComponent").attr
attrs.materials = attrs.materials .. ",apotheosis_insect_husk,apotheosis_sand_pink,templebrick_static_broken_apotheosisoft,sand_blue"
ModTextFileSetContent("data/entities/misc/perks/dissolve_powders.xml", tostring(xml))

-- Adds various liquids to freeze charge modifier
local content = ModTextFileGetContent("data/entities/particles/freeze_charge.xml")
local xml = nxml.parse(content)
local attrs = xml:all_of("MagicConvertMaterialComponent")
attrs[2].attr.from_material_array = attrs[2].attr.from_material_array .. ",apotheosis_water_fading_fast,water_fading"
attrs[2].attr.to_material_array = attrs[2].attr.to_material_array .. ",ice_static,ice_static"
ModTextFileSetContent("data/entities/particles/freeze_charge.xml", tostring(xml))

-- Adds various liquids to circle of stillness
local content = ModTextFileGetContent("data/entities/projectiles/deck/freeze_field.xml")
local xml = nxml.parse(content)
xml:add_child(nxml.parse([[
	<MagicConvertMaterialComponent
      kill_when_finished="0"
      from_material="water_fading"
      steps_per_frame="5"
      to_material="ice_static"
      is_circle="1"
      radius="72" >
    </MagicConvertMaterialComponent>
]]))
ModTextFileSetContent("data/entities/projectiles/deck/freeze_field.xml", tostring(xml))

-- Adds various liquids to freeze field perk
local content = ModTextFileGetContent("data/entities/misc/perks/freeze_field.xml")
local xml = nxml.parse(content)
xml:add_child(nxml.parse([[
	<MagicConvertMaterialComponent
      kill_when_finished="0"
      from_material="apotheosis_water_fading_fast"
      steps_per_frame="5"
      to_material="ice_static"
      is_circle="1"
      radius="72" >
    </MagicConvertMaterialComponent>
]]))
ModTextFileSetContent("data/entities/misc/perks/freeze_field.xml", tostring(xml))





--Boss health multiplier insertion
dofile_once("mods/Apotheosis/files/scripts/mod_compatibility/boss_health_multiplier_plug.lua")

--Boss vulnerability immunity insertion
dofile_once("mods/Apotheosis/files/scripts/mod_compatibility/boss_vulnerability_immune_plug.lua")

--Modifies vanilla entity data
--Try not to tinker with base noita too much, the main goal to this mod is to be an expansion pack, not a rebalance.
dofile_once("mods/Apotheosis/files/scripts/mod_compatibility/vanilla_appends.lua")

-- If Conjurer is enabled, disable this for a fix.
-- Adds custom Pixel Scenes in
if ModIsEnabled("raksa") == false then
	dofile_once("mods/Apotheosis/files/scripts/pixelscenes/scene_list.lua")
end

--Overrides some creep's settings for spoopy's alternate graphics
--Removed as it uses Spoopy's Graphics by default
--[[
if spoopyGFXSetting == true then

  --Esoteric Being
  local content = ModTextFileGetContent("data/entities/animals/esoteric_being.xml")
  local xml = nxml.parse(content)
  xml:first_of("Base"):first_of("AnimalAIComponent").attr.attack_ranged_action_frame = "2"
  xml:first_of("Base"):first_of("SpriteComponent").attr.image_file = "mods/Apotheosis/files/enemies_gfx/esoteric_being_alt.xml"
  xml:first_of("SpriteComponent").attr.offset_x = "18.5"
  xml:first_of("SpriteComponent").attr.offset_y = "17.5"
  ModTextFileSetContent("data/entities/animals/esoteric_being.xml", tostring(xml))

  local content = ModTextFileGetContent("data/entities/buildings/esoteric_being_asleep.xml")
  local xml = nxml.parse(content)
  xml:first_of("SpriteComponent").attr.image_file = "mods/Apotheosis/files/enemies_gfx/esoteric_being_alt_asleep.xml"
  ModTextFileSetContent("data/entities/buildings/esoteric_being_asleep.xml", tostring(xml))

  local content = ModTextFileGetContent("mods/Apotheosis/files/scripts/animals/angel_holy_beam_calldown_alt.lua")
  ModTextFileSetContent("mods/Apotheosis/files/scripts/animals/angel_holy_beam_calldown.lua", content)

end
]]
--





















--Master of Masters master spawner insertion, allows him to spawn Master of Mallards & Master of Immortality too.. He doesn't appreciate Master of Trolling too much to invite him in
--Note, this has been moved to a file override, could probably use string.gsub to fix that
--Note 17/07/2023, string.gsub has been used






-- Seasonal
local year, month, day, hour, minute = GameGetDateAndTimeLocal()


if seasonalSetting == true then
	-- Halloween Event
	if ((month == 10) and (day >= 15)) or seasonalForced_Halloween then
		ModLuaFileAppend("data/scripts/biomes/coalmine.lua", "mods/Apotheosis/files/scripts/biomes/seasonal/halloween.lua")                                           --Coal Mine, first area, goodluck on your run
		ModLuaFileAppend("data/scripts/biomes/coalmine_alt.lua", "mods/Apotheosis/files/scripts/biomes/seasonal/halloween.lua")                                           --Coalmine but to the west side near damp cave
		ModLuaFileAppend("data/scripts/biomes/excavationsite.lua", "mods/Apotheosis/files/scripts/biomes/seasonal/halloween.lua")                                           --Coal Pits, area 2
		ModLuaFileAppend("data/scripts/biomes/pyramid.lua", "mods/Apotheosis/files/scripts/biomes/seasonal/halloween.lua") --Presumably everything below the entrance to the pyramid
		--ModLuaFileAppend("data/scripts/biomes/sandcave.lua", "mods/Apotheosis/files/scripts/biomes/seasonal/halloween.lua") --Meant to add jackolaterns to the sandcaves, but no lamps naturally spawn down there, effort to work it in.

		local nxml = dofile_once("mods/Apotheosis/lib/nxml.lua")
		local content = ModTextFileGetContent("data/entities/animals/poring.xml")
		local xml = nxml.parse(content)
		xml:first_of("Base"):first_of("SpriteComponent").attr.image_file =
		"mods/Apotheosis/files/enemies_gfx/poring_halloween.xml"
		xml:first_of("Base"):first_of("DamageModelComponent").attr.ragdoll_filenames_file =
		"mods/Apotheosis/files/ragdolls/poring_halloween/filenames.txt"
		ModTextFileSetContent("data/entities/animals/poring.xml", tostring(xml))

		local content = ModTextFileGetContent("data/entities/animals/coal_mines/poring.xml")
		local xml = nxml.parse(content)
		xml:first_of("Base"):first_of("SpriteComponent").attr.image_file =
		"mods/Apotheosis/files/enemies_gfx/poring_halloween_weak.xml"
		xml:first_of("Base"):first_of("DamageModelComponent").attr.ragdoll_filenames_file =
		"mods/Apotheosis/files/ragdolls/poring_halloween_weak/filenames.txt"
		ModTextFileSetContent("data/entities/animals/coal_mines/poring.xml", tostring(xml))

		local content = ModTextFileGetContent("data/entities/animals/psychotic/poring.xml")
		local xml = nxml.parse(content)
		xml:first_of("Base"):first_of("SpriteComponent").attr.image_file =
		"mods/Apotheosis/files/enemies_gfx/poring_halloween.xml"
		xml:first_of("Base"):first_of("DamageModelComponent").attr.ragdoll_filenames_file =
		"mods/Apotheosis/files/ragdolls/poring_halloween/filenames.txt"
		ModTextFileSetContent("data/entities/animals/psychotic/poring.xml", tostring(xml))
	end



	-- Smissmass Event
	if ((month == 12) and (day >= 15)) or seasonalForced_Smissmass then
		local nxml = dofile_once("mods/Apotheosis/lib/nxml.lua")
		local content = ModTextFileGetContent("data/entities/animals/hisii_minecart_tnt.xml")
		local xml = nxml.parse(content)
		xml:first_of("Base"):first_of("SpriteComponent").attr.image_file =
		"mods/Apotheosis/files/enemies_gfx/hisii_minecart_tnt_santa.xml"
		xml:first_of("Base"):first_of("AnimalAIComponent").attr.attack_ranged_entity_file =
		"data/entities/projectiles/present.xml"
		xml:add_child(nxml.parse([[
      <LuaComponent
          script_source_file="mods/Apotheosis/files/scripts/animals/esoteric_being_shifted_smoke.lua"
          execute_every_n_frame="1"
          remove_after_executed="1"
          >
      </LuaComponent>
      ]]))
		ModTextFileSetContent("data/entities/animals/hisii_minecart_tnt.xml", tostring(xml))

		if ModIsEnabled("worse_enemies") then
			local content = ModTextFileGetContent("data/entities/animals/hisii_minecart.xml")
			local xml = nxml.parse(content)
			xml:first_of("Base"):first_of("SpriteComponent").attr.image_file =
			"mods/Apotheosis/files/enemies_gfx/hisii_minecart_worse_smissmass.xml"
			ModTextFileSetContent("data/entities/animals/hisii_minecart.xml", tostring(xml))
		else
			local content = ModTextFileGetContent("data/entities/animals/hisii_minecart.xml")
			local xml = nxml.parse(content)
			xml:first_of("Base"):first_of("SpriteComponent").attr.image_file =
			"mods/Apotheosis/files/enemies_gfx/hisii_minecart_smissmass.xml"
			ModTextFileSetContent("data/entities/animals/hisii_minecart.xml", tostring(xml))
		end

		if ModIsEnabled("worse_enemies") then
			local content = ModTextFileGetContent("data/entities/animals/hisii_minecart_weak.xml")
			local xml = nxml.parse(content)
			xml:first_of("Base"):first_of("SpriteComponent").attr.image_file =
			"mods/Apotheosis/files/enemies_gfx/hisii_minecart_worse_weak_smissmass.xml"
			ModTextFileSetContent("data/entities/animals/hisii_minecart_weak.xml", tostring(xml))
		else
			local content = ModTextFileGetContent("data/entities/animals/hisii_minecart_weak.xml")
			local xml = nxml.parse(content)
			xml:first_of("Base"):first_of("SpriteComponent").attr.image_file =
			"mods/Apotheosis/files/enemies_gfx/hisii_minecart_weak_smissmass.xml"
			ModTextFileSetContent("data/entities/animals/hisii_minecart_weak.xml", tostring(xml))
		end

		local nxml = dofile_once("mods/Apotheosis/lib/nxml.lua")
		local content = ModTextFileGetContent("data/entities/animals/poring.xml")
		local xml = nxml.parse(content)
		xml:first_of("Base"):first_of("SpriteComponent").attr.image_file =
		"mods/Apotheosis/files/enemies_gfx/poring_santa.xml"
		ModTextFileSetContent("data/entities/animals/poring.xml", tostring(xml))

		local nxml = dofile_once("mods/Apotheosis/lib/nxml.lua")
		local content = ModTextFileGetContent("data/entities/animals/coal_mines/poring.xml")
		local xml = nxml.parse(content)
		xml:first_of("Base"):first_of("SpriteComponent").attr.image_file =
		"mods/Apotheosis/files/enemies_gfx/poring_santa_weak.xml"
		ModTextFileSetContent("data/entities/animals/coal_mines/poring.xml", tostring(xml))
	end


	-- Birthday Event
	-- Update to be centered on 21/07/2022, this is when the first enemy was created and development officially began. Should be a fair trade off between not being the official release date but also not clashing with Halloween
	--Remember Update global_populator & global_populator_small too, wand tinkering crystal spawns are inside.
	if ((month == 7) and ((day >= 20) and (day <= 22))) or seasonalForced_Birthday then
		ModLuaFileAppend("data/scripts/biomes/hills.lua", "mods/Apotheosis/files/scripts/biomes/seasonal/birthday.lua") --Hills slightly below ground
		ModLuaFileAppend("data/scripts/biomes/coalmine.lua", "mods/Apotheosis/files/scripts/biomes/seasonal/birthday.lua") --Coal Mine, first area, goodluck on your run
		ModLuaFileAppend("data/scripts/biomes/coalmine_alt.lua",
			"mods/Apotheosis/files/scripts/biomes/seasonal/birthday.lua")                                            --Coalmine but to the west side near damp cave
		ModLuaFileAppend("data/scripts/biomes/excavationsite.lua",
			"mods/Apotheosis/files/scripts/biomes/seasonal/birthday.lua")                                            --Coal Pits, area 2
		ModLuaFileAppend("data/scripts/biomes/snowcave.lua",
			"mods/Apotheosis/files/scripts/biomes/seasonal/birthday_rare.lua")                                       --Hiisi Base
		ModLuaFileAppend("data/scripts/biomes/snowcastle.lua",
			"mods/Apotheosis/files/scripts/biomes/seasonal/birthday_rare.lua")
		ModLuaFileAppend("data/scripts/biomes/desert.lua", "mods/Apotheosis/files/scripts/biomes/seasonal/birthday.lua")
		ModLuaFileAppend("data/scripts/biomes/rainforest.lua",
			"mods/Apotheosis/files/scripts/biomes/seasonal/birthday_rare.lua")
		ModLuaFileAppend("data/scripts/biomes/vault.lua",
			"mods/Apotheosis/files/scripts/biomes/seasonal/birthday_rare.lua")
	end


	-- April Fools Event
	if ((month == 4) and (day == 1)) or seasonalForced_AprilFools then
		--Replace all hisii hobos with clowns.
		local content = ModTextFileGetContent("data/entities/animals/seasonal/hisii_hobo.xml")
		ModTextFileSetContent("data/entities/animals/hisii_hobo.xml", content)

		--Replace small fairies with lethal versions.
		local content = ModTextFileGetContent("data/entities/animals/seasonal/fairy_cheap.xml")
		ModTextFileSetContent("data/entities/animals/fairy_cheap.xml", content)

		--Replace big fairies with non-lethal versions.
		local content = ModTextFileGetContent("data/entities/animals/seasonal/fairy_big.xml")
		ModTextFileSetContent("data/entities/animals/fairy_big.xml", content)

		local randomCap = 10

		SetRandomSeed(hour + minute, hour + day)
		--10% chance for any main path biome to become weird in April Fools
		if Random(1, randomCap) == 1 then
			ModLuaFileAppend("data/scripts/biomes/vault.lua","mods/Apotheosis/files/scripts/biomes/global_everything_populator.lua")
			randomCap = randomCap + 1
		end
		if Random(1, randomCap) == 1 then
			ModLuaFileAppend("data/scripts/biomes/fungicave.lua", "mods/Apotheosis/files/scripts/biomes/global_everything_populator.lua")
			randomCap = randomCap + 1
		end
		if Random(1, randomCap) == 1 then
			ModLuaFileAppend("data/scripts/biomes/rainforest.lua", "mods/Apotheosis/files/scripts/biomes/global_everything_populator.lua")
			randomCap = randomCap + 1
		end
		if Random(1, randomCap) == 1 then
			ModLuaFileAppend("data/scripts/biomes/snowcastle.lua","mods/Apotheosis/files/scripts/biomes/global_everything_populator.lua")
			ModLuaFileAppend("mods/apotheosis/files/scripts/biomes/newbiome/lava_excavation.lua", "mods/Apotheosis/files/scripts/biomes/global_everything_populator.lua")
			randomCap = randomCap + 1
		end
		if Random(1, randomCap) == 1 then
			ModLuaFileAppend("data/scripts/biomes/snowcave.lua", "mods/Apotheosis/files/scripts/biomes/global_everything_populator.lua")
			randomCap = randomCap + 1
		end
		if Random(1, randomCap) == 1 then
			ModLuaFileAppend("data/scripts/biomes/excavationsite.lua", "mods/Apotheosis/files/scripts/biomes/global_everything_populator.lua")
			randomCap = randomCap + 1
		end
		if Random(1, randomCap) == 1 then
			ModLuaFileAppend("data/scripts/biomes/coalmine_alt.lua", "mods/Apotheosis/files/scripts/biomes/global_everything_populator.lua")
			randomCap = randomCap + 1
		end
		if Random(1, randomCap) == 1 then
			ModLuaFileAppend("data/scripts/biomes/coalmine.lua", "mods/Apotheosis/files/scripts/biomes/global_everything_populator.lua")
			randomCap = randomCap + 1
		end

		--100% chance for the Temple of the Art to be spawn everything
		ModLuaFileAppend("data/scripts/biomes/crypt.lua", "mods/Apotheosis/files/scripts/biomes/global_everything_populator.lua")



		--Remember to check global spawn files, pandora's chest spawnrate boost is managed there
	end
end













--Dark Areas
ModLuaFileAppend("data/scripts/biomes/wizardcave.lua", "mods/Apotheosis/files/scripts/biomes/suspicious.lua")      --Wizard's Den, aside from the darkness it's pretty habitable. Polymorph liquid is scarier, I can't shield that.

ModLuaFileAppend("data/scripts/biomes/crypt.lua", "mods/Apotheosis/files/scripts/biomes/suspicious.lua")           --Temple of the Arts.. who died here?
ModLuaFileAppend("data/scripts/biomes/pyramid.lua", "mods/Apotheosis/files/scripts/biomes/suspicious.lua")         --Presumably everything below the entrance to the pyramid
ModLuaFileAppend("data/scripts/biomes/fungicave.lua", "mods/Apotheosis/files/scripts/biomes/suspicious.lua")       --BUNGUS!! cave, west side of area 2 for example

ModLuaFileAppend("data/scripts/biomes/fungiforest.lua", "mods/Apotheosis/files/scripts/biomes/suspicious.lua")     --Overgrowth
ModLuaFileAppend("data/scripts/biomes/wandcave.lua", "mods/Apotheosis/files/scripts/biomes/suspicious.lua")        --Magical temple.. huh
ModLuaFileAppend("data/scripts/biomes/sandcave.lua", "mods/Apotheosis/files/scripts/biomes/suspicious.lua")        --Desert sand cave, I don't think it includes desert chasm
ModLuaFileAppend("data/scripts/biomes/vault.lua", "mods/Apotheosis/files/scripts/biomes/suspicious.lua")           --The Vault

ModLuaFileAppend("data/scripts/biomes/winter.lua", "mods/Apotheosis/files/scripts/biomes/suspicious.lua")          --Winter appears to be the snow chasm... terrifying.
ModLuaFileAppend("data/scripts/biomes/rainforest_dark.lua", "mods/Apotheosis/files/scripts/biomes/suspicious.lua") --Lukki Lair.. creepy
ModLuaFileAppend("data/scripts/biomes/vault_frozen.lua", "mods/Apotheosis/files/scripts/biomes/suspicious.lua")    --Like the vault, but way colder, worse, more hisii and with a really rude welcoming
ModLuaFileAppend("data/scripts/biomes/robobase.lua", "mods/Apotheosis/files/scripts/biomes/suspicious.lua")        --Power Plant
ModLuaFileAppend("data/scripts/biomes/the_end.lua", "mods/Apotheosis/files/scripts/biomes/suspicious.lua")         --Heaven & Hell, but for this specific lua file append I'm only adding to hell

ModLuaFileAppend( "mods/apotheosis/files/scripts/biomes/newbiome/evil_temple.lua", "mods/Apotheosis/files/scripts/biomes/suspicious.lua" ) --Temple of Sacrilegious Remains


--Secret

do -- Player Editor
	local path = "data/entities/player_base.xml"
	local xml = nxml.parse(ModTextFileGetContent(path))
	--Adds Biome tracker script to the player character, it will update their current biome difficulty and save the highest one they've ever achieved, maxing out at 7 in Heaven/Hell
	--This is currently only used for twitch integration so is disabled if TI is turned off, can be changed if needed elsewhere
	--  xml:add_child(nxml.parse([[
	--    <LuaComponent
	--      script_source_file="mods/apotheosis/files/scripts/magic/biome_difficulty_tracker.lua"
	--      execute_every_n_frame="600"
	--      execute_times="-1"
	--      remove_after_executed="0"
	--      >
	--    </LuaComponent>
	--  ]]))

	--Makes player take contact damage from cursed liquid, poisonous gas, and other materials added by Apotheosis
	--Cursed Liquid, Cursed Liquid (Static), Poisonous Gas, Radioactive Gas (Fading)
	local attrs = xml:first_of("DamageModelComponent").attr
	attrs.materials_that_damage = attrs.materials_that_damage .. ",apotheosis_cursed_liquid_red,apotheosis_cursed_liquid_red_static,poison_gas,apotheosis_radioactive_gas_fading"
	attrs.materials_how_much_damage = attrs.materials_how_much_damage .. ",0.003,0.003,0.0008,0.001"

	if HasFlagPersistent("apotheosis_card_unlocked_secret_knowledge_of_kings") and capeSetting then
		--Adds Golden Cape if check is successful
		xml:add_child(nxml.parse([[
      <LuaComponent
        script_source_file="data/apotheosis_gfx/player_cape_colour_append.lua"
        execute_every_n_frame="2"
        execute_times="1"
        remove_after_executed="1"
        >
      </LuaComponent>
    ]]))
	end

	--Adds Parallel World checker to the player
	--Adds vampirism HP scaling
	--Previously every 30 seconds, now every 10 seconds after vampirism buff
	xml:add_child(nxml.parse([[
    <LuaComponent
      script_source_file="mods/apotheosis/files/scripts/magic/player_parallel_check.lua"
      execute_every_n_frame="600"
      execute_times="-1"
      remove_after_executed="0"
      >
    </LuaComponent>
  ]]))

	--Adds Biome Check to the player
	xml:add_child(nxml.parse([[
    <Entity>
      <Base file="mods/apotheosis/files/scripts/magic/biome_effects.xml" >
      </Base>
    </Entity>
  ]]))

	--Debug
	--xml:add_child(nxml.parse([[
	--  <SpriteComponent
	--  _tags="character"
	--  alpha="1"
	--  image_file="mods/apotheosis/files/player_gfx/perk_wings.xml"
	--  next_rect_animation=""
	--  offset_x="6"
	--  offset_y="14"
	--  rect_animation="walk"
	--  z_index="0.61"
	--></SpriteComponent>
	--]]))
	ModTextFileSetContent(path, tostring(xml))

	--print(tostring(xml))
end



--Guarantees Dense Smoke modifier to appear in the coalpits for your first run when playing with Apotheosis
if ModIsEnabled("raksa") == false then
	if (HasFlagPersistent("apotheosis_card_unlocked_coalpits_dense_smoke") ~= true) then
		local filepc = "data/biome/_pixel_scenes.xml"
		if ModIsEnabled("purgatory") then
			filepc = "mods/purgatory/files/biome/_pixel_scenes.xml"
			local content = ModTextFileGetContent(filepc)
			local xml = nxml.parse(content)
			xml:first_of("mBufferedPixelScenes"):add_child(nxml.parse([[
          <PixelScene pos_x="1003" pos_y="111" just_load_an_entity="data/entities/buildings/smoke_dense_creator_apotheosis_message.xml" />
      ]]))
			ModTextFileSetContent(filepc, tostring(xml))
		elseif ModIsEnabled("noitavania") then
			filepc = "mods/noitavania/data/biome/_pixel_scenes.xml"
			local content = ModTextFileGetContent(filepc)
			local xml = nxml.parse(content)
			xml:first_of("mBufferedPixelScenes"):add_child(nxml.parse([[
          <PixelScene pos_x="192" pos_y="1635" just_load_an_entity="data/entities/buildings/smoke_dense_creator_apotheosis_message.xml" />
      ]]))
			ModTextFileSetContent(filepc, tostring(xml))
		else
			local content = ModTextFileGetContent(filepc)
			local xml = nxml.parse(content)
			xml:first_of("mBufferedPixelScenes"):add_child(nxml.parse([[
          <PixelScene pos_x="192" pos_y="1635" just_load_an_entity="data/entities/buildings/smoke_dense_creator_apotheosis_message.xml" />
      ]]))
			ModTextFileSetContent(filepc, tostring(xml))
		end


		ModLuaFileAppend("data/scripts/biomes/excavationsite.lua",
			"mods/Apotheosis/files/scripts/biomes/excavationsite_populator_densesmoke.lua")
	end
end

-- Sets biome map to the new one
--[[
if experimental_biomemap then
  ModMagicNumbersFileAdd("mods/Apotheosis/files/magic_numbers_experimental.xml") --Sets the biome map
  dofile_once( "mods/Apotheosis/files/scripts/mod_compatibility/vanilla_appends_experimental.lua" ) --appends experimental data
  Note: It would be fun to replace the entire world map one day, but that's biting off way more than I can chew, a small rat eating a whole cow level huge,
  A single person with 0 mods for a game trying to make an Rlcraft modpack huge
  Maybe after Apotheosis is done and we have a bunch of biome assets, enemy assets, spell, perk, item, etc assets, we could make a new world
  But until that day comes, We're sticking to the plan!
else
  ModMagicNumbersFileAdd("mods/Apotheosis/files/magic_numbers.xml") --Sets the biome map
  side note: maybe in that new world enemies could drop wands directly instead of finding them on pedestals
end
]]
--


--Custom biome modifiers
--ModTextFileSetContent("data/scripts/biome_modifiers.lua", ModTextFileGetContent("mods/apotheosis/files/scripts/biome_modifiers/biome_modifiers.lua"))

--More Musical Magic implementation, coded by Y🍵
if ModTextFileGetContent("data/moremusicalmagic/musicmagic.lua") == nil then
	local data = ModTextFileGetContent("data/moremusicalmagic/compatibility/musicmagic.lua")
	ModTextFileSetContent("data/moremusicalmagic/musicmagic.lua", data)
end
ModLuaFileAppend("data/moremusicalmagic/musicmagic.lua", "data/moremusicalmagic/songs_default.lua")
ModLuaFileAppend("data/moremusicalmagic/musicmagic.lua", "data/moremusicalmagic/songs_apotheosis.lua")


--Set Custom Seed (And Check for Secret Seeds)
dofile_once("mods/apotheosis/files/scripts/setup/secret_seeds.lua")

--Set the biome map
--This is handled underneath the custom seed check as the earliest biomemap append gets priority it seems
ModMagicNumbersFileAdd("mods/Apotheosis/files/magic_numbers.xml")

--Appending extra modifiers
ModLuaFileAppend("data/scripts/gun/gun_extra_modifiers.lua", "mods/apotheosis/files/scripts/spells/gun_extra_populator.lua")

--Polymorph pool addition preperation
--Will be controlled via mod settings until it's pushed to main
--If you want to enable it, you can toggle "Expanded Polymorph Pool" in the mod settings

if ModIsEnabled("Global_Poly") then
	ModLuaFileAppend("mods/global_poly/files/scripts/poly_pool.lua", "mods/apotheosis/files/scripts/mod_compatibility/poly_control_compat.lua")
else
	local old_on_world_init = OnWorldInitialized
	function OnWorldInitialized()
		dofile_once("mods/apotheosis/files/scripts/mod_compatibility/polymorph_pool.lua")
		dofile_once("mods/apotheosis/files/scripts/magic/creature_shift_file_image_refresh.lua")

		if old_on_world_init then old_on_world_init() end
	end
end

--Makes the Creature Shift Icon available to be editted during run-time
function OnModInit()
	ModImageMakeEditable( "data/ui_gfx/animal_icons/creature_shift/creature_shift_ui.png", 16, 16 )

	local path, csi_enemies = "data/ui_gfx/animal_icons/_list.txt", {}
	for enemy in ModTextFileGetContent(path):gmatch("[^\r\n]+") do
		csi_enemies[#csi_enemies+1] = enemy
	end
	for k=1,#csi_enemies do
		ModImageMakeEditable( table.concat({"data/ui_gfx/animal_icons/",csi_enemies[k],".png"}), 16, 16 )
		ModImageMakeEditable( table.concat({"data/ui_gfx/animal_icons/creature_shift/",csi_enemies[k],".png"}), 16, 16 )
		--Debug Data
		--print(table.concat({"making image writable: ",table.concat({"data/ui_gfx/animal_icons/",csi_enemies[k],".png"})}))
	end
end

--Randomly cause a fungal shift/creature shift at any time, at random.
--And print Happy April Fools at the start of the run
--Happy april fools <3
function AprilFoolsPlayerSpawn(plyr_id)

	local comp = EntityGetFirstComponentIncludingDisabled(plyr_id,"DamageModelComponent")
	local hp = ComponentGetValue2(comp,"hp")
	local max_hp = ComponentGetValue2(comp,"max_hp")

	if hp ~= 4 then return end
	if max_hp ~= 4 then return end

	if seasonalSetting and (((month == 4) and (day == 1)) or seasonalForced_AprilFools) then
		local x, y = EntityGetTransform(player_entity)
		local cid = EntityLoad("mods/Apotheosis/files/entities/misc/essence/moon_fungus_curse_slow.xml", x, y)
		EntityAddChild(player_entity, cid)
		local cid = EntityLoad("mods/Apotheosis/files/entities/misc/essence/moon_creature_curse_slow.xml", x, y)
		EntityAddChild(player_entity, cid)
		local cid = EntityLoad("mods/Apotheosis/files/entities/misc/essence/creature_shift_april_fools_bootup.xml", x, y) --20 random creature shifts at the start of the run
		EntityAddChild(player_entity, cid)

		GamePrint("$sign_apotheosis_aprilfools_intro")
	end
end

-- Creature shift fix upon reloading world
-- Keep this at the bottom of the file, and only let one of this function exist, silly
function OnPlayerSpawned(player_entity)
	--Conga 04/12/2023
	--Warns the player to get off the god damn main branch, I'm tired of getting crash reports just for it to end up being this, man.
	--I know someone's going to stumble across this tired exhausted message one day, and I just want to say, I wanted to have faith in people, and believe that they would have read the multiple warnings on the mod page to play on the beta branch.
	--I was HOPING people would see the pinned thread called "Game Crashes" and take interest in it if they're experiencing problems, but that's asking too much I suppose.
	--I feel like I'm running a daycare sometimes, God Dammit.
	--urgh, alright, tired rant over
	--Thankyou for playing
	--
	--09/04/2024 Beta was pushed to main :')
	--
	--[[
	if GameIsBetaBuild() == false then
		EntityLoad("mods/apotheosis/files/entities/props/sign_motd/sign_motd_painpeko.xml",260,-85)
	end
	]]--

	local x, y = EntityGetTransform(player_entity) --This was just "player" by default but I feel like something broke.. I hope not
	EntityLoad("mods/Apotheosis/files/entities/special/entity_shift_refresh_fixer.xml", x, y)

	--Previously a game print to warn against Ride Minecarts
	--[[if ModIsEnabled("Ride Minecart") == true then
    GamePrint("Error, could not initialise hopping into minecarts because of [Ride Minecarts], Apotheosis should function as normal otherwise though.")
  end]]--

	--Post Ascension scenery
	--[[
	if HasFlagPersistent("apotheosis_card_unlocked_ending_apotheosis_02") and HasFlagPersistent("apotheosis_card_unlocked_sea_to_potion") == false then

		--Gather world entity data
		local worldEntity = GameGetWorldStateEntity()
		local comp = EntityGetFirstComponentIncludingDisabled(worldEntity,"WorldStateComponent")

		--Set weather up to be nice
		ComponentSetValue2(comp,"intro_weather",true)
		ComponentSetValue2(comp,"time",0.55)
		ComponentSetValue2(comp,"time_dt",0.5)
		ComponentSetValue2(comp,"fog",0)
		ComponentSetValue2(comp,"rain",0)

		EntityLoad("mods/apotheosis/files/entities/particles/upwards_trail.xml", 239, -229)
		EntityLoad("mods/apotheosis/files/entities/particles/upwards_trail.xml", 764, -860)
		
		AddFlagPersistent("apotheosis_card_unlocked_sea_to_potion")
	end
	]]--

	--Reset Red Sand fx
	GameSetPostFxParameter("conga_red_sand_effect_amount", 0, 0, 0, 0)
	GlobalsSetValue("conga_red_sand_effect_amount",0)

	--Warns the player if Mo Creeps is enabled, to shut it off
	if ModIsEnabled("Mo_Creeps") then
		GamePrintImportant("WARNING: MO CREEPS IS ENABLED", "Apotheosis & More Creeps should not be enabled at the same time, Mo Creeps content is already inside apotheosis.")
	end

	--[[
	--Warns the player if Nightmare is enabled, that the hardcore seed exists
	if ModIsEnabled("Nightmare") and HasFlagPersistent("apotheosis_card_unlocked_nightmarewarning") == false then
		GamePrintImportant("WARNING: MO CREEPS IS ENABLED", "Apotheosis & More Creeps should not be enabled at the same time, Mo Creeps content is already inside apotheosis.")
		AddFlagPersistent("apotheosis_card_unlocked_nightmarewarning")
	end
	]]--

	--Debug Testing for intro scene
	--RemoveFlagPersistent( "apotheosis_intro_cutscene" )

	--Handles the intro cutscene if the player hasn't encountered it yet
	if ModIsEnabled("Mo_Creeps") == false and HasFlagPersistent("apotheosis_intro_cutscene") == false then
		EntityLoad("mods/apotheosis/files/entities/intro/controller_scenes.xml", x, y)
		--This is added when the cutscene ends to prevent a softlock
		--AddFlagPersistent( "apotheosis_intro_cutscene" )
	end

	if custom_seed then
		GamePrint("$sign_apotheosis_custom_seed")

		local seed = string.lower(ModSettingGet( "Apotheosis.custom_seed" ))
		if seed == "hardcore" or seed == "nightcore" then
			GameAddFlagRun("apotheosis_hardmode")
		end
	end

	--Handles AprilFools related code
	AprilFoolsPlayerSpawn(player_entity)

	--Calculate RNG
	SetRandomSeed(111, 222)
	if Random(1, 2000) == 1 then
		GameAddFlagRun(table.concat({ "apothe", "osis_", "div", "ine_red_fi", "sh" }))
	end
end

--Custom Materials
ModMaterialsFileAdd("mods/Apotheosis/files/scripts/materials/secret_materials.xml")
ModMaterialsFileAdd("mods/Apotheosis/files/scripts/materials/custom_materials.xml")


ModLuaFileAppend("data/scripts/items/potion.lua", "mods/Apotheosis/files/scripts/potions/potion_appends.lua")
ModLuaFileAppend("data/scripts/items/powder_stash.lua", "mods/Apotheosis/files/scripts/potions/powder_stash_appends.lua")
ModLuaFileAppend("data/scripts/items/potion_aggressive.lua", "mods/Apotheosis/files/scripts/potions/potion_aggressive_appends.lua")

function OnMagicNumbersAndWorldSeedInitialized()
	--You can just edit material file data after appending it and it works, uhh, cool, thanks Nolla; Thanks Wondible
	do --Setup Magic Catalyst data
		dofile("mods/apotheosis/files/scripts/materials/secret_materials_generate.lua")
		GenerateMagicCatalyst()
	end
end
