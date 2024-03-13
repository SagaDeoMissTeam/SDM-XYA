import crafttweaker.api.block.BlockState;
import crafttweaker.api.BracketDumpers;
import crafttweaker.api.bracket.BracketHandlers;
import crafttweaker.api.bracket.ResourceLocationBracketHandler;
import crafttweaker.api.item.IItemStack;
import mods.itemstages.ItemStages;
import crafttweaker.api.game.Game;

import mods.orestages.OreStages;




val oreStage as BlockState[BlockState] = {
    <blockstate:minecraft:coal_ore> : <blockstate:minecraft:stone>,
    <blockstate:scalinghealth:heart_crystal_ore> : <blockstate:minecraft:stone>,
    <blockstate:minecraft:iron_ore> : <blockstate:minecraft:stone>,
    <blockstate:minecraft:copper_ore> : <blockstate:minecraft:stone>,
    <blockstate:minecraft:gold_ore> : <blockstate:minecraft:stone>,
    <blockstate:minecraft:redstone_ore> : <blockstate:minecraft:stone>,
    <blockstate:minecraft:redstone_ore:lit=false> : <blockstate:minecraft:stone>,
    <blockstate:minecraft:redstone_ore:lit=true> : <blockstate:minecraft:stone>,
    <blockstate:minecraft:emerald_ore> : <blockstate:minecraft:stone>,
    <blockstate:minecraft:lapis_ore> : <blockstate:minecraft:stone>,
    <blockstate:minecraft:diamond_ore> : <blockstate:minecraft:stone>,
    <blockstate:scalinghealth:power_crystal_ore> : <blockstate:minecraft:stone>,
    <blockstate:mna:vinteum_ore> : <blockstate:minecraft:stone>,
    <blockstate:minecraft:nether_gold_ore> : <blockstate:minecraft:netherrack>,
    <blockstate:minecraft:nether_quartz_ore> : <blockstate:minecraft:netherrack>,
    <blockstate:minecraft:ancient_debris> : <blockstate:minecraft:netherrack>,
    <blockstate:majruszsdifficulty:enderium_shard_ore> : <blockstate:minecraft:end_stone>,
    <blockstate:betterend:thallasium_ore> : <blockstate:minecraft:end_stone>,
    <blockstate:betterend:ender_ore> : <blockstate:minecraft:end_stone>,
    <blockstate:betterend:amber_ore> : <blockstate:minecraft:end_stone>,
};

for key,value in oreStage{
    OreStages.addOreStage("spawnOre", key, value);
}

for mod in loadedMods.getMods(){
    if(mod.id == "minecraft" || mod.id == "ftbquests" || mod.id == "lootr") continue;
    mods.recipestages.Recipes.setRecipeStageByMod("disableContent", mod.id);
    ItemStages.createModRestriction(mod.id, "disableContent");
}

for entity in BracketDumpers.getEntityTypeDump(){
    var d1 as string = entity.replace("<", " ").replace(">", " ");
    var name as string = "";
    for chr in 12 .. d1.length - 1{
        name += d1[chr];
    }
    if(<resource:${name}>.getNamespace() != ("minecraft")){
        mods.mobstages.MobStages.addStage("disableContent", name);
    }
}

// for item in game.getItemStacks(){
//     if(item.registryName.getNamespace() != ("minecraft")){
//         mods.recipestages.Recipes.setRecipeStage("disableContent", item);
//         ItemStages.restrict(item, "disableContent");
//     }
// }

// for key in BracketDumpers.getItemBracketDump(){
//     var name = key.replace("<", " ").replace(">", " ");
//     var dClass  = "";
//     for chr in 6 .. name.length - 1{
//         dClass += name[chr];
//     }
//     if(!("withTag" in dClass)){
//         var item as IItemStack = BracketHandlers.getItem(dClass);
//         if(item.registryName.getNamespace() != ("minecraft")){
//             mods.recipestages.Recipes.setRecipeStage("disableContent", item);
//             ItemStages.restrict(item, "disableContent");
//         }
//     }
// }