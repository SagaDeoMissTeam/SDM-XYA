import mods.sdmcrtplus.utils.file.File;
import mods.sdmengine.MinecraftConstants;
import mods.sdmengine.snbt.SDMCompoundTag;
import mods.sdmengine.snbt.SNBTCompoundTag;
import crafttweaker.api.data.MapData;
import mods.sdmengine.snbt.SNBT;
import crafttweaker.api.text.Component;

public class SDMFile{
    public static val scriptFolder as string = MinecraftConstants.ScriptsFolder + "/_sdata/";
    public static val developersFolder as string = MinecraftConstants.ScriptsFolder + "/src/main/player/";
    public static val developersFile as string = developersFolder + "DevelopersData.snbt";


    public static init(nbt as MapData, name as Component) as void{
        new File(scriptFolder).mkdirs();

        var data as SNBTCompoundTag = SDMCompoundTag.of(nbt) as SNBTCompoundTag;
        SNBT.write(scriptFolder + name.getString() + ".snbt", data);
    }

    public static read(name as Component) as SNBTCompoundTag?{
        return SNBT.read(scriptFolder + name.getString() + ".snbt");
    }


}