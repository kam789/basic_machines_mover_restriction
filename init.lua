minetest.register_privilege("mover", {description = "able to use basic_machines:mover.", give_to_singleplayer = false})

-- listed nodes require mover priv for placement
-- to add additional nodes, insert new entries into machine_list

local machine_list = {
    "basic_machines:mover",
}

minetest.register_on_mods_loaded(function()
    for machinecount = 1, #machine_list do
        if minetest.registered_items[machine_list[machinecount]] then
            minetest.override_item(machine_list[machinecount], {
                on_place = function(itemstack, placer, pointed_thing)
                    local can_mess = minetest.check_player_privs(placer.get_player_name(placer), {mover = true})
                    if not can_mess then
                        minetest.chat_send_player(placer:get_player_name(), "Insufficient privs, you're not allowed to use this.")
                        return
                    end
                    return minetest.item_place(itemstack, placer, pointed_thing)
                end
            })
        end
    end
end)
