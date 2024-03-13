import crafttweaker.api.text.Component;
import stdlib.List;
import crafttweaker.api.entity.type.player.Player;
import mods.sdmengine.snbt.SDMCompoundTag;
import mods.sdmengine.snbt.SNBTCompoundTag;
import crafttweaker.api.data.MapData;
import mods.sdmengine.snbt.SNBT;
import crafttweaker.api.data.ListData;
import mods.rpgworld.Manager;

public class DeveloperStateMachine{
    public val player as Player;
    public var isActivate as bool;
    public var level as int;

    protected this(player: Player){
        this.player = player;
        this.isActivate = false;
        this.level = Developers.getLevel(player);
    }

    public static of(player: Player) as DeveloperStateMachine?{
        var state as DeveloperStateMachine = new DeveloperStateMachine(player);
        if(Developers.isDeveloper(player)){
            if("developerData" in player.customData && !player.customData["developerData"].isEmpty()){
                state.deserialize(player.customData["developerData"]);
                return state;
            } else {
                player.customData["developerData"] = state.serialize();
                return state;
            }
        }
        return null;
    }

    public executeCommand(command as string) as bool{
        if(isActivate){
            if(command in DevCommands.COMMANDS){
                if(DevCommands.COMMANDS[command].level <= this.level){
                    if(command == "help"){
                        for key,command in DevCommands.COMMANDS{
                            if(command.level <= this.level){
                                player.sendMessage(key);
                            }
                        }
                        return true;
                    }

                

                    if(command == "sdmDevMode"){
                        deactivateCommandHelper();
                        return true;
                    }

                    if(command == "openScreen 1"){
                        Manager.openScreen(player);
                        return true;
                    }

                    if(command == "openScreen 2"){
                        Manager.openLoreScreen(player);
                        return true;
                    }

                    if(command == "playerData"){
                        player.sendMessage(player.customData as string);
                        return true;
                    }

                    if(command == "sendInfo"){
                        Manager.sendUnlock(player, "Это Заголовок", "Жили-были два утёнка. Первый утёнок мечтал стать разработчиком сборок, а второй – Full Stack разработчиком. Однако, судьба распорядилась иначе. Первый утёнок стал оператором токарного станка, а второй – таксистом.");
                        return true;
                    }

                    if(command == "allContent"){
                        var stM as PlayerStateMachine = PlayerStateMachine.of(player) as PlayerStateMachine;
                        stM.unlockMap();
                        stM.unlockMiniMap();
                        stM.unlockJade();
                        stM.unlockCurios();
                        stM.unlockSkillTree();
                        player.addGameStage("disableContent");
                        return true;
                    }

                    if(command == "loreStarted"){
                        var lore as LoreStateMachine = LoreStateMachine.of(player) as LoreStateMachine;
                        if(lore.listStarted.isEmpty) {
                            player.sendMessage("empty");
                            return true;
                        }
                        for i in lore.listStarted{
                            player.sendMessage(i.getId());
                        }
                        return true;
                    }

                    if(command == "loreCompleted"){
                        var lore as LoreStateMachine = LoreStateMachine.of(player) as LoreStateMachine;
                        if(lore.listComplete.isEmpty) {
                            player.sendMessage("empty");
                            return true;
                        }
                        for i in lore.listComplete{
                            player.sendMessage(i.getId());
                        }
                        return true;
                    }
                }
            }
        } else {
            if(command == "sdmDevMode"){
                activateCommandHelper();
                return true;
            }
        }

        return false;
    }

    public activateCommandHelper() as void{
        this.isActivate = true;
        player.updateCustomData({"developerData" : serialize()});
        player.sendMessage("Режим разработчика Активирован !");
    }
    public deactivateCommandHelper() as void{
        this.isActivate = false;
        player.updateCustomData({"developerData" : serialize()});
        player.sendMessage("Режим разработчика Деактивирован !");
    }

    public block() as void{
        player.updateCustomData({"developerData" : new MapData()});
    }

    public serialize(): MapData{
        var nbt: MapData = new MapData();
        nbt["isActivate"] = isActivate as bool;
        return nbt;
    }

    public deserialize(nbt: MapData): void{
        if(nbt.isEmpty()) return;

        this.isActivate = nbt["isActivate"] as bool;
    }
}