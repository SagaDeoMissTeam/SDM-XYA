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
import mods.rpgworld.Manager;

public class LoreManager{


    public static var registered as LoreStateMachine = LoreStateMachine.NULL as LoreStateMachine;


    public static serialize(): MapData{
        var data as MapData = new MapData();
        if(LoreManager.registered.id != -1){
            data["lore"] = LoreManager.registered.serialize();
        } else {
            data["lore"] = new MapData();
        }
        return data;
    }

    public static deserialize(nbt: MapData): void{
        if("lore" in nbt){
            var state as LoreStateMachine = new LoreStateMachine();
            state.deserialize(nbt["lore"] as MapData);
            LoreManager.registered = state;
        }
    }
}