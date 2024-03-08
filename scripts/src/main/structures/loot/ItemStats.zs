import stdlib.List;
import crafttweaker.api.item.IItemStack;


        /*----------------------------------------------------------------
                        Класс с характеристиками предметов
        ------------------------------------------------------------------*/
public class ItemStats{

    public static val propertyList as List<ItemStatsBase> = new List<ItemStatsBase>();

    public static val VOID_DAMAGE as ItemStatsBase = register(ItemStatsBase.of("void_damage", [ItemStatsType.WEAPON], ItemStatsRarity.RARE));
    public static val VOID_DAMAGE_BUFF as ItemStatsBase = register(ItemStatsBase.of("void_damage_buff", [ItemStatsType.WEAPON], ItemStatsRarity.RARE));
    public static val DIVINE_DAMAGE as ItemStatsBase = register(ItemStatsBase.of("divine_damage", [ItemStatsType.WEAPON], ItemStatsRarity.RARE));
    public static val DIVINE_DAMAGE_BUFF as ItemStatsBase = register(ItemStatsBase.of("divine_damage_buff", [ItemStatsType.WEAPON], ItemStatsRarity.RARE));
    public static val CHAOS_DAMAGE as ItemStatsBase = register(ItemStatsBase.of("chaos_damage", [ItemStatsType.WEAPON], ItemStatsRarity.RARE));
    public static val CHAOS_DAMAGE_BUFF as ItemStatsBase = register(ItemStatsBase.of("chaos_damage_buff", [ItemStatsType.WEAPON], ItemStatsRarity.RARE));
    public static val VOID_RESIST as ItemStatsBase = register(ItemStatsBase.of("void_resist", [ItemStatsType.ARMOR], ItemStatsRarity.RARE));
    public static val DIVINE_RESIST as ItemStatsBase = register(ItemStatsBase.of("divine_resist", [ItemStatsType.ARMOR], ItemStatsRarity.RARE));
    public static val CHAOS_RESIST as ItemStatsBase = register(ItemStatsBase.of("chaos_resist", [ItemStatsType.ARMOR], ItemStatsRarity.RARE));
    public static val CRITICAL_HIT_CHANCE as ItemStatsBase = register(ItemStatsBase.of("critical_hit_chance", [ItemStatsType.ARMOR], ItemStatsRarity.RARE));

    public static register(id as ItemStatsBase) as ItemStatsBase{
        propertyList.add(id);
        return id;
    }

    public static getKeys() as List<string>{
        var list as List<string> = new List<string>();
        for d1 in propertyList{
            list.add(d1.name);
        }
        return list;
    }

    public static getMap() as ItemStatsBase[string]{
        var map as ItemStatsBase[string] = {};
        for d1 in propertyList{
            map[d1.name] = d1;
        }
        return map;
    }

    public static getArmorStats() as List<ItemStatsBase>{
        var list as List<ItemStatsBase> = new List<ItemStatsBase>();
        for d1 in propertyList{
            if(ItemStatsType.ARMOR in d1.type) list.add(d1);
        }

        return list;
    }

    public static getWeaponStats() as List<ItemStatsBase>{
        var list as List<ItemStatsBase> = new List<ItemStatsBase>();
        for d1 in propertyList{
            if(ItemStatsType.WEAPON in d1.type) list.add(d1);
        }

        return list;
    }

}

    /*----------------------------------------------------------------
                    Базовый класс характеристик оружия
    ------------------------------------------------------------------*/
public class ItemStatsBase{
    public var name as string;
    public var type as ItemStatsType[];
    public var value as double = 0.0;
    public var rarity as ItemStatsRarity;

    public this(name as string, type as ItemStatsType[], rarity as ItemStatsRarity){
        this.name = name;
        this.type = type;
        this.rarity = rarity;
    }

    public this(name as string, value as double, type as ItemStatsType[], rarity as ItemStatsRarity){
        this.name = name;
        this.type = type;
        this.value = value;
        this.rarity = rarity;
    }

    public static of(name as string, type as ItemStatsType[], rarity as ItemStatsRarity) as ItemStatsBase{
        return new ItemStatsBase(name, type, rarity);
    }

    public instance(value as double) as ItemStatsBase{
        this.value = value;
        return this;
    }

    public copy() as ItemStatsBase{
        return new ItemStatsBase(this.name, this.value, this.type, this.rarity);
    }
}

    /*----------------------------------------------------------------
                    Таблици с редкостью характеристих
    ------------------------------------------------------------------*/
public enum ItemStatsRarity{
    COMMON(1.0),
    UNCOMMON(0.8),
    RARE(0.6),
    EPIC(0.4),
    LEGENDARY(0.2),
    ANCIENT(0.08);

    var chance as double;
    this(chance as double){
        this.chance = chance;
    }

}