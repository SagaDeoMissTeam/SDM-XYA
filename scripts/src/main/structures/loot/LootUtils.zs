import crafttweaker.api.item.IItemStack;
import crafttweaker.api.world.Container;
import mods.rpgworld.utils.CustomRandom;
import crafttweaker.api.data.MapData;
import stdlib.List;
import mods.crtultimate.math.Random;


    /*----------------------------------------------------------------
                Класс отвечающий за всё что происходит
                    с предметами с характеристиками
    ------------------------------------------------------------------*/
public class LootUtils{


    public static generateLootOnChest(container as Container) as void{
        /*----------------------------------------------------------------
            Метод генерации предметов с характеристиками в инвентаре
        ------------------------------------------------------------------*/
    }

    public static createItem() as IItemStack{
        /*----------------------------------------------------------------
                    Метод содания базового предмета
        ------------------------------------------------------------------*/
        var item as IItemStack = LootList.lootTable[CustomRandom.getRandom(0, LootList.lootTable.length as int)].item;
        return generateStats(item);
    }

    protected static generateStats(item as IItemStack) as IItemStack{
        /*----------------------------------------------------------------
                    Метод генерации характристик предметов
        ------------------------------------------------------------------*/
        val stats as List<ItemStatsBase> = ItemStats.getWeaponStats();
        // var itemData as MapData = new MapData(item.tag.asMap());
        var rarity = Random.nextInt(0, 5);

        var statIndex as int = Random.nextInt(0, stats.length as int);

        var sdmData as MapData = new MapData();

        // if(Random.nextBoolean()){
        sdmData.merge({stats[statIndex].name : CustomRandom.getRandom(0.0, 50.0, 0.0)});
        // } else {
        //     sdmData.merge({stats[statIndex].name : -CustomRandom.getRandom(0.0, 50.0, 0.0)});
        // }

        item.getOrCreateTag().merge({"sdm_data" : sdmData});
        return item;
    }
}