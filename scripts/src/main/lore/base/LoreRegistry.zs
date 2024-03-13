import stdlib.List;
import crafttweaker.api.text.Component;

public class LoreRegistry{

    public static val NULL as ILore = new LoreText("null");

    public static val LORE_KEY_MAP as ILore[string] = {};
    // public static val LORE_MAP as ILore[ILore] = {};
    public static val LORE_LIST as List<ILore> = new List<ILore>();


    public static init(): void{
        var registerILore as ILore = register(new LoreText("dev_test", [Component.literal("yes")]));
    }

    public static register(lore: ILore): ILore{
        return register(lore, NULL);
    }

    public static register(lore: ILore, parent: ILore): ILore{
        lore.setParent(parent);
        if(lore.getId() in LORE_KEY_MAP){
            LORE_KEY_MAP[lore.getId() + "_1"] = lore;
            println("[SDM ERRORS] Dublicate names lore: " + lore.getId());
        } else LORE_KEY_MAP[lore.getId()] = lore;
        LORE_LIST.add(lore);
        return lore;
    }
}