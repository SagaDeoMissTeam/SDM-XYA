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
import crafttweaker.api.entity.type.player.ServerPlayer;
import crafttweaker.api.text.Component;

public class LoreHelper{


    public static getILore(nbt: MapData): ILore{
        var iLore as ILore = new LoreText();
        if("type" in nbt){
            if(nbt["type"] as string == LoreType.TEXT.name){
                iLore = new LoreText();
                iLore.deserialize(nbt);
                return iLore;
            }
        }

        return iLore;
    }

    public static loreChatRun(player: Player, message: Component): bool{
        var stateMachine as LoreStateMachine = LoreManager.registered as LoreStateMachine;

        if(message.getString() == "main" && stateMachine.mainHero == "null" && stateMachine.secondHero != player.uuid as string){
            stateMachine.mainHero = player.uuid as string;
            stateMachine.needSync = true;
            player.sendMessage("Вы будете главным героем");
            QuestUtils.of(player).setComplete("14E518CE93CC495B");
            return true;
        }

        if(message.getString() == "second" && stateMachine.secondHero == "null" && stateMachine.mainHero != player.uuid as string){
            stateMachine.secondHero = player.uuid as string;
            stateMachine.needSync = true;
            player.sendMessage("Вы будете второстепенным героем");
            QuestUtils.of(player).setComplete("14E518CE93CC495B");
            return true;
        }

        return false;
    }

    public static selecteMainHero(): void{

    }

    public static selecteSecondHero(): void{

    }
}