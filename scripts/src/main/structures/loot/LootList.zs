import crafttweaker.api.item.IItemStack;
import crafttweaker.api.data.MapData;
import stdlib.List;

    /*----------------------------------------------------------------
                    Класс с возможными предметами
                которые могут получить характеристики
                при генерации в сундуках и не только
    ------------------------------------------------------------------*/
public class LootList {
    public static var lootTable as List<LootItem> = new List<LootItem>();

    public static register(item as LootItem) as LootItem{
        this.lootTable.add(item);
        return item;
    }

    public static init() as void{
        register(LootItem.of(<item:minecraft:golden_sword>.withTag({affix_data: {sockets: 1}}), 0.2));
        register(LootItem.of(<item:minecraft:wooden_sword>, 0.8));
        register(LootItem.of(<item:minecraft:stone_sword>, 0.75));
        register(LootItem.of(<item:minecraft:golden_sword>, 0.60));
        register(LootItem.of(<item:minecraft:iron_sword>, 0.62));
        register(LootItem.of(<item:born_in_chaos_v1:spiritual_sword>, 0.60));
        register(LootItem.of(<item:minecraft:iron_axe>, 0.60));
        register(LootItem.of(<item:minecraft:wooden_axe>, 0.8));
        register(LootItem.of(<item:minecraft:stone_axe>, 0.75));
        register(LootItem.of(<item:minecraft:diamond_axe>, 0.2));
        register(LootItem.of(<item:minecraft:golden_axe>, 0.6));
        register(LootItem.of(<item:skilltree:copper_ring>, 0.5));
        register(LootItem.of(<item:skilltree:golden_ring>, 0.5));
        register(LootItem.of(<item:skilltree:iron_ring>, 0.5));
    }
}


    /*----------------------------------------------------------------
                    Калсс с настройками для лута
    ------------------------------------------------------------------*/
public class LootItem {
    public var item as IItemStack;
    public var chance as double;
    public var data as MapData;

    public this(item as IItemStack, chance as double){
        this(item, chance, new MapData());
    }

    public this(item as IItemStack, chance as double, data as MapData){
        this.item = item;
        this.chance = chance;
        this.data = data;
    }

    public static of(item as IItemStack, chance as double) as LootItem{
        return new LootItem(item, chance, new MapData());
    }

    public static of(item as IItemStack, chance as double, data as MapData) as LootItem{
        return new LootItem(item, chance, data);
    }
}