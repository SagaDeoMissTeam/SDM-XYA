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


public class LoreStateMachine{
    public var isServer as bool = false;
    public var id as int = 0;
    public var player as Player? = null;
    public val listComplete as List<ILore> = new List<ILore>();
    public val listStarted as List<ILore> = new List<ILore>();
    public var mainHeroName as string = "TODO: MAIN HERO";
    public var mainHero as string = "null";
    public var secondHero as string = "null";
    public var secondHeroName as string = "TODO: SECOND HERO";
    public var teamPlayer as List<string> = new List<string>();
    public var progress as int = 0;
    public var timers as List<TimerBase> = new List<TimerBase>();
    public var needSync as bool = false;

    public var isSended as int = -1;
    public var tiemSended as int = 0;
    public var isWait as bool = true;

    public static var NULL as LoreStateMachine = new LoreStateMachine(-1);

    public this() {

    }

    public this(d1 as int){
        this.id = d1;
    }

    public this(player as Player) {
        this.player = player;
    }

    public registerTimer(timer as TimerBase) as void{
        timers.add(timer);
    }

    public onTick() as void{
        if(this.id == -1) return;
        if(!timers.isEmpty){
            var remove as int = -1;
            for timer in 0 .. timers.length as int{
                if(!timers[timer].isEnd){
                    timers[timer].onTick();
                } else {
                    remove = timer;
                    break;
                }
            }

            if(remove != -1) timers.remove(remove);
            needSync = true;
        }

        if(isSended != 4){

            if(tiemSended % 5 == 0){
                switch(isSended){
                    case 0: {
                        player.sendMessage("Вы активировали сюжетный режим !");
                        break;
                    }
                    case 1: {
                        player.sendMessage("Если вы играете с кем-то то вы должны решить кто из вас будет главным героем, а кто второстепенным.");
                        break;
                    }
                    case 2: {
                        player.sendMessage("Для этого напишите одно из следующих сообщений");
                        break;
                    }
                    case 3: {
                        player.sendMessage("    §6main§r - (Главный Герой)");
                        player.sendMessage("    §6second§r - (Второстепенный герой)");
                    }
                    default:
                        break;
                }

                this.isSended = this.isSended + 1;
            }

            this.tiemSended = tiemSended + 1;
            needSync = true;
        }


        if(needSync){
            syncData();
        }
    }


    public static of(player as Player) as LoreStateMachine{
        val state as LoreStateMachine = new LoreStateMachine(player);
        val data as MapData = player.customData as MapData;

        if("gameSetting" in data){
            if("loreStateMachine" in data["gameSetting"]){
                state.deserialize(data["gameSetting"]["loreStateMachine"]);
                if(LoreManager.registered.id == -1) {
                    LoreManager.registered = state;
                    LoreManager.registered.isServer = true;
                }
                return state;
            } else {
                LoreManager.registered = state;
                LoreManager.registered.isServer = true;
            }
        }

        if(LoreManager.registered.id != -1){
            if(LoreManager.registered.mainHero == player.uuid as string || LoreManager.registered.secondHero == player.uuid as string){
                LoreManager.registered.player = player;
                return LoreManager.registered;
            }

            for d2 in LoreManager.registered.teamPlayer{
                if(d2 == player.uuid as string){
                    LoreManager.registered.player = player;
                    return LoreManager.registered;
                }
            }
        }

        return state;
    }

    public isMainHero(player: Player) as bool{
        return this.mainHero == player.uuid as string;
    }
    public isSecondHero(player: Player) as bool{
        return this.secondHero == player.uuid as string;
    }

    public setMainHero(player: Player) as void{
        this.mainHero = player.uuid as string;
    }

    public setSecondHero(player: Player) as void{
        this.secondHero = player.uuid as string;
        this.teamPlayer.add(player.uuid as string);
    }

    public checkIsAllOnline() as bool{
        var d1 as bool = false;
        var d2 as bool = false;
        for serverPlayer in Manager.getServer().getPlayerList().getPlayers(){
            if(serverPlayer.uuid as string == mainHero){
                d1 = true;
            }
            if(serverPlayer.uuid as string == secondHero && secondHero != "null"){
                d2 = true;
            }
        }
        return d1 & d2;
    }

    public addTeamPlayer(teamPlayerName as string) as void{
        teamPlayer.add(teamPlayerName);
    }

    public sendILore(lore as ILore) as void{
        lore.run(player);
        listComplete.add(lore);
    }

    public isLore() as bool{
        return "plot" in player.customData["gameSetting"];
    }

    public updateLoreProgress(progress as int) as void{
        if(!("gameSetting" in player.customData)) player.updateCustomData({"gameSetting" : new MapData()});
        val data = serialize();
        data["lore_progress"] = progress;
        player.updateCustomData({"gameSetting" : {"loreStateMachine" : new MapData()}});
        player.updateCustomData({"gameSetting" : {"loreStateMachine" : data}});
    }

    public getLoreProgress() as int{
        if(isLore()){
            if("lore_progress" in player.customData["gameSetting"]["loreStateMachine"]){
                return player.customData["gameSetting"]["loreStateMachine"]["lore_progress"] as int;
            }
        }

        return -1;
    }

    public syncData() as void{
        if(isServer){
            var pl as ServerPlayer? = null;
            if(mainHero != "null"){
                pl = Manager.getServer().getPlayerList().getPlayer(Manager.fromString(mainHero));
                if(pl != null){
                    syncDataWihtPlayer(pl as ServerPlayer as Player);
                }
            }
            if(secondHero != "null"){
                pl = Manager.getServer().getPlayerList().getPlayer(Manager.fromString(secondHero));
                if(pl != null){
                    syncDataWihtPlayer(pl as ServerPlayer as Player);
                }
            }
        } else {
            if(!("gameSetting" in player.customData)) player.updateCustomData({"gameSetting" : new MapData()});
            val data = player.customData["gameSetting"];
            player.updateCustomData({"gameSetting" : {"loreStateMachine" : new MapData()}});
            player.updateCustomData({"gameSetting" : {"loreStateMachine" : serialize()}});
        }
    }

    public syncDataWihtPlayer(pl: Player) as void{
        if(!("gameSetting" in player.customData)) player.updateCustomData({"gameSetting" : new MapData()});
        pl.updateCustomData({"gameSetting" : {"loreStateMachine" : new MapData()}});
        pl.updateCustomData({"gameSetting" : {"loreStateMachine" : serialize()}});
    }

    public serialize(): MapData{
        var data as MapData = new MapData();

        var listCompleteData as ListData = new ListData();
        for d1 in listComplete{
            listCompleteData.add(d1.serialize());
        }

        var listStartedData as ListData = new ListData();
        for d1 in listStarted{
            listStartedData.add(d1.serialize());
        }

        var teamPlayerData as ListData = new ListData();
        for d1 in teamPlayer{
            teamPlayerData.add(new StringData(d1));
        }

        var timerData as ListData = new ListData();
        for time in timers{
            timerData.add(time.serialize());
        }

        data["id"] = id;
        data["isServer"] = isServer;
        data["isSended"] = isSended;
        data["tiemSended"] = tiemSended;
        data["isWait"] = isWait;
        data["lore_progress"] = progress;
        data["mainHeroName"] = mainHeroName;
        data["secondHeroName"] = secondHeroName;
        data["mainHero"] = mainHero;
        data["secondHero"] = secondHero;
        data["teamPlayer"] = teamPlayerData;
        data["listComplete"] = listCompleteData;
        data["listStarted"] = listStartedData;
        data["timerData"] = timerData;


        return data;
    }

    public deserialize(nbt: MapData) as void{
        this.id = nbt["id"] as int;
        this.isServer = nbt["isServer"] as bool;
        this.isWait = nbt["isWait"] as bool;
        this.mainHero = nbt["mainHero"] as string;
        this.mainHeroName = nbt["mainHeroName"] as string;
        this.secondHeroName = nbt["secondHeroName"] as string;
        this.progress = nbt["lore_progress"] as int;
        this.isSended = nbt["isSended"] as int;
        this.tiemSended = nbt["tiemSended"] as int;
        this.secondHero = nbt["secondHero"] as string;

        var listCompleteData as ListData = nbt["listComplete"] as ListData;
        for d1 in listCompleteData{
            listComplete.add(LoreHelper.getILore(d1 as MapData));
        }

        var listStartedData as ListData = nbt["listStarted"] as ListData;
        for d1 in listStartedData{
            listStarted.add(LoreHelper.getILore(d1 as MapData));
        }

        var teamPlayerData as ListData = nbt["teamPlayer"] as ListData;
        for d1 in teamPlayerData{
            teamPlayer.add(d1 as string);
        }

        var timerData as ListData = nbt["timerData"] as ListData;
        for timer in timerData{
            var d1 as TimerBase = new TimerBase(player);
            d1.deserialize(timer as MapData);
            timers.add(d1);
        }

    }
}