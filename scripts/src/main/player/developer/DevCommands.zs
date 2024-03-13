import crafttweaker.api.data.MapData;
import crafttweaker.api.entity.type.player.Player;
import mods.sdmengine.snbt.SNBTCompoundTag;
import mods.sdmcrtplus.utils.file.File;
import mods.sdmengine.entity.skills.PlayerSkillsProvider;
import mods.sdmengine.snbt.NBTUtilsHelper;
import mods.sdmengine.snbt.SDMCompoundTag;
import mods.sdmengine.snbt.ListTag;
import stdlib.List;
import mods.sdmengine.snbt.Tag;
import crafttweaker.api.item.IItemStack;
import crafttweaker.api.data.ListData;
import crafttweaker.api.data.StringData;

public class DevCommands{
    public static val COMMANDS as DevCommand[string] = {};



    public static init() as void {
        //register(new DevCommand("customData", 3));
        register(new DevCommand("sdmDevMode", 1));
        register(new DevCommand("openScreen 1", 3));
        register(new DevCommand("openScreen 2", 3));
        register(new DevCommand("playerData", 2));
        register(new DevCommand("sendInfo", 1));
        register(new DevCommand("allContent", 1));
        register(new DevCommand("loreStarted", 2));
        register(new DevCommand("loreCompleted", 2));
        register(new DevCommand("help", 1));
    }

    public static register(command as DevCommand) as void{
        COMMANDS[command.command] = command;
    }
}

public class DevCommand{
    public var command as string;
    public var level as int;

    public this(command as string, level as int){
        this.command = command;
        this.level = level;
    }

    public abstract run(player: Player) as void;
}