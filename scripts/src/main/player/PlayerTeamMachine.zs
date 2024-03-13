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

public class PlayerTeamMachine{
    public var id as string;
    public var ownerId as string;
    public var members as List<string> = new List<string>();


    public this(id as string, ownerId as string){
        this.id = id;
        this.ownerId = ownerId;
    }



    public serialize(): MapData{
        var nbt: MapData = new MapData();

        return nbt;
    }

    public deserialize(nbt: MapData): void{

    }
}