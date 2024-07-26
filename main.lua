-- ArtificerImprovements v1.0.0
-- SmoothSpatula

log.info("Successfully loaded ".._ENV["!guid"]..".")

function setup_arti()
    local skills = gm.variable_global_get("class_skill")
    local artiZ = skills[120]

    --artiZ[8] = 1 -- damage
    artiZ[13] = false -- require_key_press
    artiZ[14] = true -- allow_buffered_input
    artiZ[20] = false --  hold facing direction
    artiZ[9] = 8.0 -- number of chakrams
    artiZ[23] = true -- ignore_aim_direction

    local speed_multi = 2.0
    gm.sprite_set_speed(gm.constants.sArtiShoot1_1A, speed_multi, 1)
    gm.sprite_set_speed(gm.constants.sArtiShoot1_2A, speed_multi, 1)
    gm.sprite_set_speed(gm.constants.sArtiShoot1_1B, speed_multi, 1)
    gm.sprite_set_speed(gm.constants.sArtiShoot1_2B, speed_multi, 1)
end

gm.pre_script_hook(gm.constants.callback_execute, function(self, other, result, args)
    -- Hover
    if args[1].value == callbacks["onPlayerStep"] and self.class == 13.0 then
        if self.moveUpHold == 1.0 and self.pVspeed > 0.0 then
            self.pVspeed = 0.0
        end
    end
    -- Skill setup
    if args[1].value == callbacks["onPlayerInit"] then 
        setup_arti()
    end
end)

-- make her glacier intangible
gm.post_script_hook(gm.constants.instance_create_depth, function(self, other, result, args)
    if result.value.object_name == "oArtiSnap" then
        result.value.intangible = true
    end
end)

-- == Section Callbacks == --

local callback_names = gm.variable_global_get("callback_names")
callbacks = {}

for i = 1, #callback_names do
    callbacks[callback_names[i]] = i - 1
end
