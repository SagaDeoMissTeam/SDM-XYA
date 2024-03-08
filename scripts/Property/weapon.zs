import crafttweaker.api.item.IItemStack;
import crafttweaker.api.text.Component;

public virtual class BasicClass{
    public this(){

    }


    public getWeapons() as IItemStack[]{
        return [] as IItemStack[];
    }
}

public class Eques : BasicClass{
    public static final val weapons as IItemStack[] = [   
        <item:minecraft:wooden_sword>,
        <item:minecraft:stone_sword>,
        <item:minecraft:iron_sword>,
        <item:minecraft:diamond_sword>,
        <item:minecraft:netherite_sword>
    ];
    public static final val armor as IItemStack[] = [
        <item:minecraft:leather_helmet>,
        <item:minecraft:leather_chestplate>,
        <item:minecraft:leather_leggings>,
        <item:minecraft:leather_boots>,
        <item:minecraft:chainmail_helmet>,
        <item:minecraft:chainmail_chestplate>,
        <item:minecraft:chainmail_leggings>,
        <item:minecraft:chainmail_boots>,
        <item:minecraft:iron_helmet>,
        <item:minecraft:iron_chestplate>,
        <item:minecraft:iron_leggings>,
        <item:minecraft:iron_boots>
    ];

    public this(){
        super();
    }


    public getWeapons() as IItemStack[]{
        return weapons;
    }
}

public class Barbarus : BasicClass{

    public static final val weapons as IItemStack[] = [   
        <item:minecraft:stone_axe>,
        <item:minecraft:wooden_axe>,
        <item:minecraft:iron_axe>,
        <item:minecraft:netherite_axe>,
        <item:minecraft:diamond_axe>,
        <item:betterend:aeternium_axe>,
    ];
    public static final val armor as IItemStack[] = [
        <item:minecraft:leather_helmet>,
        <item:minecraft:leather_chestplate>,
        <item:minecraft:leather_leggings>,
        <item:minecraft:leather_boots>,
        <item:minecraft:chainmail_helmet>,
        <item:minecraft:chainmail_chestplate>,
        <item:minecraft:chainmail_leggings>,
        <item:minecraft:chainmail_boots>,
        <item:minecraft:iron_helmet>,
        <item:minecraft:iron_chestplate>,
        <item:minecraft:iron_leggings>,
        <item:minecraft:iron_boots>
    ];

    public this(){
        super();
    }
}
public class Berserkr : BasicClass{

    public static final val weapons as IItemStack[] = [   
        <item:minecraft:stone_axe>,
        <item:minecraft:wooden_axe>,
        <item:minecraft:iron_axe>,
        <item:minecraft:netherite_axe>,
        <item:minecraft:diamond_axe>,
        <item:betterend:aeternium_axe>,
    ];
    public static final val armor as IItemStack[] = [
        <item:minecraft:leather_helmet>,
        <item:minecraft:leather_chestplate>,
        <item:minecraft:leather_leggings>,
        <item:minecraft:leather_boots>,
        <item:majruszsdifficulty:tattered_helmet>,
        <item:majruszsdifficulty:tattered_chestplate>,
        <item:majruszsdifficulty:tattered_leggings>,
        <item:majruszsdifficulty:tattered_boots>,
    ];

    public this(){
        super();
    }
}
public class VeneficusEques : BasicClass{

    public static final val weapons as IItemStack[] = [   
        <item:minecraft:wooden_sword>,
        <item:minecraft:stone_sword>,
        <item:minecraft:iron_sword>,
        <item:minecraft:diamond_sword>,
        <item:minecraft:netherite_sword>
    ];
    public static final val armor as IItemStack[] = [
        <item:minecraft:leather_helmet>,
        <item:minecraft:leather_chestplate>,
        <item:minecraft:leather_leggings>,
        <item:minecraft:leather_boots>,
        <item:majruszsdifficulty:tattered_helmet>,
        <item:majruszsdifficulty:tattered_chestplate>,
        <item:majruszsdifficulty:tattered_leggings>,
        <item:majruszsdifficulty:tattered_boots>,
    ];

    public this(){
        super();
    }
}


public class Palatinus : BasicClass{

    public static final val weapons as IItemStack[] = [   
        <item:minecraft:wooden_sword>,
        <item:minecraft:stone_sword>,
        <item:minecraft:iron_sword>,
        <item:minecraft:diamond_sword>,
        <item:minecraft:netherite_sword>,
        <item:stalwart_dungeons:wooden_hammer>,
        <item:stalwart_dungeons:stone_hammer>,
        <item:stalwart_dungeons:iron_hammer>,
        <item:stalwart_dungeons:golden_hammer>,
        <item:stalwart_dungeons:netherite_hammer>,
        <item:stalwart_dungeons:diamond_hammer>,
        <item:bosses_of_mass_destruction:earthdive_spear>,
        <item:minecraft:trident>,
    ];
    public static final val armor as IItemStack[] = [
        <item:minecraft:iron_helmet>,
        <item:minecraft:iron_chestplate>,
        <item:minecraft:iron_leggings>,
        <item:minecraft:iron_boots>,
        <item:minecraft:netherite_helmet>,
        <item:minecraft:netherite_chestplate>,
        <item:minecraft:netherite_leggings>,
        <item:minecraft:netherite_boots>,
        <item:minecraft:diamond_helmet>,
        <item:minecraft:diamond_chestplate>,
        <item:minecraft:diamond_leggings>,
        <item:minecraft:diamond_boots>,
        <item:minecraft:golden_helmet>,
        <item:minecraft:golden_chestplate>,
        <item:minecraft:golden_leggings>,
        <item:minecraft:golden_boots>,
    ];

    public this(){
        super();
    }
}

// var item1 = [
//     <item:aquamirae:terrible_sword>,
//     <item:betterend:aeternium_sword>,
//     <item:betterend:thallasium_sword>,
//     <item:betterend:terminite_sword>,
//     <item:born_in_chaos_v1:darkwarblade>,
//     <item:born_in_chaos_v1:sharpened_dark_metal_sword>,
//     <item:majruszsdifficulty:wither_sword>,
//     <item:majruszsdifficulty:enderium_sword>,
//     <item:minecells:blood_sword>,
//     <item:seadwellers:depth_sword>,
//     <item:minecells:cursed_sword>,
//     <item:minecells:broadsword>,
//     <item:minecraft:shield>,
//     <item:epicpaladins:arclight_sword>,
//     <item:epicpaladins:jade_sword>,
//     <item:epicpaladins:moonlight_sword>,
//     <item:epicpaladins:bloodstone_sword>,
//     <item:epicpaladins:sculk_sword>,
//     <item:epicpaladins:cryorium_sword>,
//     <item:epicpaladins:angel_sword>,
//     <item:queen_bee:stinger_sword>,
//     <item:stalwart_dungeons:tungsten_sword>,
//     <item:stalwart_dungeons:chorundum_sword>,
//     <item:minecraft:wooden_axe>,
//     <item:minecraft:stone_axe>,
//     <item:minecraft:iron_axe>,
//     <item:minecraft:golden_axe>,
//     <item:minecraft:diamond_axe>,
//     <item:minecraft:netherite_axe>,
//     <item:betterend:aeternium_axe>,
//     <item:betterend:thallasium_axe>,
//     <item:born_in_chaos_v1:great_reaper_axe>,
//     <item:seadwellers:depth_axe>,
//     <item:majruszsdifficulty:enderium_axe>,
//     <item:betterend:terminite_axe>,
//     <item:epicpaladins:arclight_axe>,
//     <item:epicpaladins:jade_axe>,
//     <item:epicpaladins:moonlight_axe>,
//     <item:epicpaladins:bloodstone_axe>,
//     <item:epicpaladins:sculk_axe>,
//     <item:epicpaladins:cryorium_axe>,
//     <item:epicpaladins:cryorium_battle_axe>,
//     <item:epicpaladins:sculk_axe>,
//     <item:stalwart_dungeons:tungsten_axe>,
//     <item:stalwart_dungeons:chorundum_axe>,
//     <item:bosses_of_mass_destruction:earthdive_spear>,
//     <item:minecraft:trident>,
//     <item:stalwart_dungeons:wooden_hammer>,
//     <item:stalwart_dungeons:stone_hammer>,
//     <item:stalwart_dungeons:iron_hammer>,
//     <item:stalwart_dungeons:golden_hammer>,
//     <item:stalwart_dungeons:diamond_hammer>,
//     <item:stalwart_dungeons:netherite_hammer>,
// ] as IItemStack[];


// for i in item1{
//     i.addTooltip(Component.literal("§6Класс : Воин"));
// }