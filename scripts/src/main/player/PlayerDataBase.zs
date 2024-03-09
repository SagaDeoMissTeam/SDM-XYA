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

public class PlayerDataBase{
    protected var machine as PlayerStateMachine?;
    protected var player as Player;

    public static of(player as Player) as PlayerDataBase{
        return new PlayerDataBase(player, PlayerStateMachine.of(player));
    }

    public this(player as Player){
        this.player = player;
        this.machine = null;
    }

    public this(player as Player, machine as PlayerStateMachine){
        this.player = player;
        this.machine = machine;
    }

    public serialize() as MapData{
        /*----------------------------------------------------------------
            Метод сохраниения данных в MapData
        ------------------------------------------------------------------*/
        var data as MapData = new MapData();
        // data["vanillaData"] = player.data;

        data["skillTree"] = PlayerSkillsProvider.getSkill(player).serializeNBT();
        data["vanillaCustomData"] = player.customData;
        
        var curiosData as SNBTCompoundTag = new SDMCompoundTag() as SNBTCompoundTag; 
        var curiosList as ListTag = new ListTag() as ListTag;
        for key, curio in player.getCuriosInventory().curios{
            var item as SNBTCompoundTag = new SDMCompoundTag() as SNBTCompoundTag;
            item.putString("type", key);
            NBTUtilsHelper.putItemStack(item, "item", curio.stacks.getStackInSlot(0));
            curiosList.add(item);
        }
        curiosData.put("curios", curiosList);
        data.merge(curiosData.getMapData());

        var sdData as SNBTCompoundTag = new SDMCompoundTag() as SNBTCompoundTag;
        NBTUtilsHelper.putContainerItems(sdData, "inventory", player.inventory);
        data.merge(sdData.getMapData());

        SDMFile.init(data, player.name);
        return data;
    }

    public deserialize() as void{
        var dataNull as SNBTCompoundTag? = SDMFile.read(player.name) as SNBTCompoundTag?;
        if(dataNull == null) {
            machine = PlayerStateMachine.of(player);
            return;
        }
        var data as MapData = dataNull.getMapData();
        if("vanillaData" in data) {
            var vanillaData as MapData = data["vanillaData"];
            player.data.merge(vanillaData);
        }
        if("vanillaCustomData" in data){
            var vanillaCustomData as MapData = data["vanillaCustomData"];
            player.customData.merge(vanillaCustomData);
            machine = PlayerStateMachine.of(player);
        }
        if("skillTree" in data){
            PlayerSkillsProvider.getSkill(player).syncData(player, data["skillTree"]);
        }
        if(dataNull.contains("inventory")){
            NBTUtilsHelper.setItemToContainerIgnoreAir(dataNull, "inventory", player.inventory);
        }
        if(dataNull.contains("curios")){
            var curiosItems as List<IItemStack> = new List<IItemStack>();
            var curiosList as ListTag = dataNull.getList("curios");
            var size as int = curiosList.size();
            for curiosData in 0 .. size{
                var itemData as SNBTCompoundTag = SDMCompoundTag.of(curiosList.getCompound(curiosData)) as SNBTCompoundTag;
                if(itemData.contains("item")){
                    curiosItems.add(NBTUtilsHelper.getItemStack(itemData, "item").asIItemStack());
                }
            }

            var curiosSlot as int = 0;
            for key, curio in player.getCuriosInventory().curios{
                if(curiosItems[curiosSlot] != <item:minecraft:air>){
                    curio.stacks.setStackInSlot(0, curiosItems[curiosSlot]);
                }
                curiosSlot++;
            }
        }

        new File(SDMFile.scriptFolder + player.name.getString() + ".snbt").delete();
    }
}