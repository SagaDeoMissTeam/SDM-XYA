import crafttweaker.api.entity.type.player.Player;
import crafttweaker.api.data.MapData;
import stdlib.List;
import crafttweaker.api.data.IData;
import crafttweaker.api.data.ListData;
import crafttweaker.api.data.DoubleData;
import crafttweaker.api.item.IItemStack;

import crafttweaker.api.world.Container;
import mods.rpgworld.utils.CustomRandom;
import mods.crtultimate.math.Random;
import crafttweaker.api.entity.type.player.Inventory;

public class PlayerPropertyUtils{

    public val player as Player;

    public static of(player as Player) as PlayerPropertyUtils{
        return new PlayerPropertyUtils(player as Player);
    }

    this(player as Player){
        this.player = player;
    }

    public run() as void{
        if(("gameSetting" in player.customData && !("sdm_runned" in player.customData["gameSetting"]))){
            if("random_start_kit" in player.customData["gameSetting"]){
                StarterItems.give(player);
            }
            if("randomspawndimension" in player.customData["gameSetting"]){
                spawnToRandomDimension();
            }

            player.customData["gameSetting"].merge({"sdm_runned" : true});
        }
    }

    protected spawnToRandomDimension() as void{

    }
}

public class StarterItems{
    public static val itemList as List<StarterItem> = new List<StarterItem>();

    public static init() as void{
        register(StarterItem.of(<item:minecraft:wooden_sword>, 100.0));
        register(StarterItem.of(<item:minecraft:wooden_shovel>, 100.0));
        register(StarterItem.of(<item:minecraft:wooden_pickaxe>, 100.0));
        register(StarterItem.of(<item:minecraft:wooden_axe>, 100.0));
        register(StarterItem.of(<item:minecraft:enchanted_golden_apple>, 1.0));
        register(StarterItem.of(<item:minecraft:golden_apple>, 10.0, 1,2));
        register(StarterItem.of(<item:minecraft:bread>, 75.0, 5,32));
        register(StarterItem.of(<item:minecraft:diamond>, 10.0));
        register(StarterItem.of(<item:minecraft:netherite_ingot>, 1.0));
        register(StarterItem.of(<item:minecraft:nether_star>, 0.05));
        register(StarterItem.of(<item:minecraft:netherite_sword>, 0.05));
        register(StarterItem.of(<item:minecraft:netherite_sword>, 0.03, true));
        register(StarterItem.of(<item:minecraft:leather_helmet>, 100.0, true));
        register(StarterItem.of(<item:minecraft:leather_chestplate>, 100.0, true));
        register(StarterItem.of(<item:minecraft:leather_leggings>, 100.0, true));
        register(StarterItem.of(<item:minecraft:leather_boots>, 100.0, true));
        register(StarterItem.of(<item:minecraft:coal>, 75.0, 2, 10));
        register(StarterItem.of(<item:minecraft:poppy>, 100.0));
        register(StarterItem.of(<item:minecraft:feather>, 75.0, 4, 12));
        register(StarterItem.of(<item:minecraft:string>, 75.0, 4, 12));
        register(StarterItem.of(<item:minecraft:iron_nugget>, 60.0, 4, 36));
        register(StarterItem.of(<item:minecraft:bone>, 74.0, 2, 6));
        register(StarterItem.of(<item:minecraft:wheat>, 74.0, 2, 6));
        register(StarterItem.of(<item:minecraft:flint>, 74.0, 2, 6));
        register(StarterItem.of(<item:minecraft:stick>, 74.0, 2, 6));
        register(StarterItem.of(<item:minecraft:leather>, 74.0, 2, 6));
        register(StarterItem.of(<item:minecraft:snowball>, 74.0, 2, 6));
    }

    public static register(item as StarterItem) as void{
        itemList.add(item);
    }

    public static getRandomItem() as StarterItem?{
        var list as List<StarterItem> = new List<StarterItem>();
        var chance as double = CustomRandom.lerp(0.0,StarterItems.itemList.length as int);
        var current as double = 0.0;
        for i in StarterItems.itemList{
            if(current <= chance && chance < current + i.chance){
                list.add(i);
            }
        }

        if(!list.isEmpty){
            return list[Random.nextInt(list.length as int)];
        }

        return null;
    }

    public static give(player as Player) as void{
        var listItems as List<IItemStack> = new List<IItemStack>();
        var count as int = Random.nextInt(1,7);
        var iteration = 0;
        while(listItems.length as int < count){
            if(iteration >= 1000) break;
            var stItem as StarterItem? = StarterItems.getRandomItem() as StarterItem?;
            if(stItem != null){
                var item as IItemStack = stItem.generateStats();
                if(stItem.countMin < stItem.countMax){
                    item = item * Random.nextInt(stItem.countMin, stItem.countMax);
                } else item = item * stItem.countMax;
                listItems.add(item);
            }
            iteration++;
        }


        for i in listItems{
            player.addItem(i);
        }
    }
}

public class StarterItem{
    public var item as IItemStack;
    public var chance as double = 0.0;
    public var data as MapData;
    public var isGen as bool;
    public var countMin as int = 1;
    public var countMax as int = 1;

    public static of(item as IItemStack, chance as double) as StarterItem{
        return new StarterItem(item, chance);
    }
    public static of(item as IItemStack, chance as double, isGen as bool) as StarterItem{
        return new StarterItem(item, chance, isGen);
    }
    public static of(item as IItemStack, chance as double, countMin as int, countMax as int) as StarterItem{
        return new StarterItem(item, chance, countMin, countMax);
    }
    public static of(item as IItemStack, chance as double, isGen as bool, countMin as int, countMax as int) as StarterItem{
        return new StarterItem(item, chance, isGen, countMin, countMax);
    }

    public this(item as IItemStack, chance as double, isGen as bool){
        this.item = item;
        this.chance = chance;
        this.data = new MapData();
        this.isGen = isGen;
    }
    public this(item as IItemStack, chance as double){
        this.item = item;
        this.chance = chance;
        this.data = new MapData();
        this.isGen = false;
    }
    public this(item as IItemStack, chance as double, isGen as bool, countMin as int, countMax as int){
        this.item = item;
        this.chance = chance;
        this.data = new MapData();
        this.isGen = isGen;
        this.countMin = countMin;
        this.countMax = countMax;
    }
    public this(item as IItemStack, chance as double, countMin as int, countMax as int){
        this.item = item;
        this.chance = chance;
        this.data = new MapData();
        this.isGen = false;
        this.countMin = countMin;
        this.countMax = countMax;
    }

    public generateStats() as IItemStack{
        if(isGen){
            return LootUtils.generateBasicStats(item, 10.0);
        }

        return item;
    }


}