import mods.sdmengine.snbt.SDMCompoundTag;
import mods.sdmengine.snbt.SNBTCompoundTag;
import mods.sdmengine.snbt.CompountTag;
import mods.sdmengine.snbt.SNBT;
import mods.sdmengine.MinecraftConstants;
import crafttweaker.api.entity.type.player.ServerPlayer;
import mods.sdmengine.snbt.NBTUtilsHelper;
import mods.sdmengine.snbt.NBTLevelUtilsHelper;

public class PlayerData{

    public static savePlayerInventory(player as ServerPlayer) as bool{
        val data as SNBTCompoundTag = new SDMCompoundTag() as SNBTCompoundTag;
        NBTUtilsHelper.writeData(data,"timeSave");
        NBTUtilsHelper.putContainerItems(data, "inventory", player.inventory);
        return ModpackDataUtils.saveDataWithName("playerData/inventory/" + player.uuid as string + ".snbt", data);
    }

    public static readPlayerInventory(player as ServerPlayer) as bool{
        val data as SNBTCompoundTag? = ModpackDataUtils.readDataWithName("playerData/inventory/" + player.uuid as string + ".snbt") as SNBTCompoundTag?;
        if(data == null) return false;
        val data2 as SNBTCompoundTag = data as SNBTCompoundTag;
        NBTUtilsHelper.setItemToContainerWithItems(data2, "inventory", player.inventory);
        return true;
    }
}