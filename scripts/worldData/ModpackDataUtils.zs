import mods.sdmengine.snbt.SDMCompoundTag;
import mods.sdmengine.snbt.SNBTCompoundTag;
import mods.sdmengine.snbt.SNBT;
import mods.sdmengine.MinecraftConstants;

public class ModpackDataUtils{
    protected static val dataFolder as string = MinecraftConstants.getWorldFolder() + "/modpackData/";
    protected static val scriptFolder as string = MinecraftConstants.GameFolder;

    public this(){

    }

    public static saveDataWithName(fileName as string, nbt as SDMCompoundTag) as bool{
        return SNBT.write(dataFolder + fileName, nbt);
    }
    public static readDataWithName(fileName as string) as SNBTCompoundTag?{
        return SNBT.read(dataFolder + fileName) as SNBTCompoundTag?;
    }

    public static saveDataToWorld(nbt as SDMCompoundTag) as bool{
        return SNBT.write(dataFolder + "modpackData.snbt", nbt);
    }
    public static readDataFromWorld() as SNBTCompoundTag?{
        return SNBT.read(dataFolder + "modpackData.snbt");
    }

    public static saveGlobalData(fileName as string, nbt as SDMCompoundTag) as bool{
        return SNBT.write(scriptFolder + fileName, nbt);
    }
    public static readGlobalData(fileName as string) as SNBTCompoundTag{
        return SNBT.read(scriptFolder + fileName);
    }
}
