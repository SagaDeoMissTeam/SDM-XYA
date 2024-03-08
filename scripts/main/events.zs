import crafttweaker.forge.api.event.item.ItemPickupEvent;
import crafttweaker.api.entity.Entity;
import crafttweaker.api.block.Block;
import crafttweaker.api.world.Level;
import crafttweaker.api.world.ServerLevel;
import crafttweaker.api.util.math.BlockPos;
import crafttweaker.api.resource.ResourceLocation;
import crafttweaker.api.data.MapData;
import crafttweaker.api.entity.type.player.Player;
import mods.sdmultimate.events.world.StructureSpawnPreEvent;

import mods.sdmcrtplus.utils.file.File;
import mods.sdmcrtplus.utils.file.FileWriter;
import mods.sdmcrtplus.utils.file.FileUtils;
import mods.sdmcrtplus.utils.file.Path;

events.register<crafttweaker.forge.api.event.item.ItemPickupEvent>(event => {
    var player = event.entity;
    var level as ServerLevel = player.level as ServerLevel;
    if(level.isClientSide) return;
    if(event.stack == <item:minecraft:coal>){
        ReplacerSaver.saveZone(player as Player as Entity, -10, -5, -10, 10, 5, 10, "sdmtest", level.server);
    }
    if(event.stack == <item:minecraft:diamond>){
        ReplacerFileLoader.load(player as Player as Entity, "sdmtest", level.server);
    }
});