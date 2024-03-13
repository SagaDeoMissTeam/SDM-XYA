import crafttweaker.api.entity.type.player.Player;
import crafttweaker.api.data.MapData;
import stdlib.List;
import crafttweaker.api.data.IData;
import crafttweaker.api.data.ListData;
import crafttweaker.api.data.DoubleData;
import crafttweaker.api.item.IItemStack;
import crafttweaker.forge.api.event.tick.TickEventType;
import crafttweaker.forge.api.event.tick.PlayerTickEvent;
import mods.rpgworld.Manager;
import crafttweaker.api.entity.type.player.ServerPlayer;

        /*----------------------------------------------------------------
            Класс атрибутов/характеристик игрока
        ------------------------------------------------------------------*/
public class PlayerStateMachine{
    public var player as Player;
    public var propertyList as List<PlayerStatBase> = new List<PlayerStatBase>();
    public var timers as List<TimerBase> = new List<TimerBase>();
    public var needSync as bool = false;

    public registerTimer(timer as TimerBase) as void{
        timers.add(timer);
    }

    public onTick() as void{
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


        if(needSync){
            syncData();
        }
    }


    public static of(player as Player) as PlayerStateMachine{
        /*----------------------------------------------------------------
            Позволяет получить характеристики игрока если они есть
            Позволяет создать новые характеристики игрока если их нет
        ------------------------------------------------------------------*/
        val data as MapData = player.customData as MapData;
        var state as PlayerStateMachine = new PlayerStateMachine(player);
        if("gameSetting" in data){
            if("playerSateMachine" in data["gameSetting"]){
                state.deserialize(data["gameSetting"]["playerSateMachine"]);
                return state;
            }
        }

        state.generateBaseStats();
        state.syncData();
        return state;
    }

    public this(){
    }

    public this(player as Player){
        this.player = player;
    }

    public add(state as PlayerStatBase) as PlayerStateMachine{
        propertyList.add(state);
        return this;
    }

    public unlockMap() as void{
        var data as MapData = serialize();
        data["journey_map"] = true;
        player.updateCustomData({"gameSetting" : {"playerSateMachine" : data}});
        Manager.syncClientData(player as ServerPlayer);
        Manager.sendUnlock(player, "sdm.unlock.journey_map", "sdm.unlock.journey_map.description");
        needSync = false;
    }
    public lockMap() as void{
        var data as MapData = serialize();
        data["journey_map"] = false;
        player.updateCustomData({"gameSetting" : {"playerSateMachine" : data}});
        Manager.syncClientData(player as ServerPlayer);
        needSync = false;
    }
    public unlockMiniMap() as void{
        var data as MapData = serialize();
        data["journey_mini_map"] = true;
        player.updateCustomData({"gameSetting" : {"playerSateMachine" : data}});
        Manager.syncClientData(player as ServerPlayer);
        Manager.sendUnlock(player, "sdm.unlock.journey_mini_map", "sdm.unlock.journey_mini_map.description");
        needSync = false;
    }
    public lockMiniMap() as void{
        var data as MapData = serialize();
        data["journey_mini_map"] = false;
        player.updateCustomData({"gameSetting" : {"playerSateMachine" : data}});
        Manager.syncClientData(player as ServerPlayer);
        needSync = false;
    }
    public unlockJade() as void{
        var data as MapData = serialize();
        data["jade"] = true;
        player.updateCustomData({"gameSetting" : {"playerSateMachine" : data}});
        Manager.syncClientData(player as ServerPlayer);
        Manager.sendUnlock(player, "sdm.unlock.jade", "sdm.unlock.jade.description");
        needSync = false;
    }
    public lockJade() as void{
        var data as MapData = serialize();
        data["jade"] = false;
        player.updateCustomData({"gameSetting" : {"playerSateMachine" : data}});
        Manager.syncClientData(player as ServerPlayer);
        needSync = false;
    }
    public unlockCurios() as void{
        var data as MapData = serialize();
        data["unlockCuriios"] = true;
        player.updateCustomData({"gameSetting" : {"playerSateMachine" : data}});
        Manager.syncClientData(player as ServerPlayer);
        Manager.sendUnlock(player, "sdm.unlock.curios", "sdm.unlock.curios.description");
        needSync = false;
    }
    public lockCurios() as void{
        var data as MapData = serialize();
        data["unlockCuriios"] = false;
        player.updateCustomData({"gameSetting" : {"playerSateMachine" : data}});
        Manager.syncClientData(player as ServerPlayer);
        needSync = false;
    }

    public unlockSkillTree() as void{
        var data as MapData = serialize();
        data["unlockSkillTree"] = true;
        player.updateCustomData({"gameSetting" : {"playerSateMachine" : data}});
        Manager.syncClientData(player as ServerPlayer);
        Manager.sendUnlock(player, "sdm.unlock.skill_tree", "sdm.unlock.skill_tree.description");
        needSync = false;
    }

    public lockSkillTree() as void{
        var data as MapData = serialize();
        data["unlockSkillTree"] = false;
        player.updateCustomData({"gameSetting" : {"playerSateMachine" : data}});
        Manager.syncClientData(player as ServerPlayer);
        needSync = false;
    }

    public syncData() as void{
        /*----------------------------------------------------------------
            Метод синхронизации новых данных игрока
        ------------------------------------------------------------------*/
        if(!("gameSetting" in player.customData)) player.updateCustomData({"gameSetting" : new MapData()});
        val data = player.customData["gameSetting"];
        player.updateCustomData({"gameSetting" : {"playerSateMachine" : new MapData()}});
        player.updateCustomData({"gameSetting" : {"playerSateMachine" : serialize()}});
        Manager.syncClientData(player as ServerPlayer);
        needSync = false;
    }

    public serialize() as MapData{
        /*----------------------------------------------------------------
            Метод сохраниения характеристик в MapData
        ------------------------------------------------------------------*/
        val data as MapData = new MapData();
        var list as List<IData> = new List<IData>();
        for property in propertyList{
            list.add(property.serialize());
        }
        var timerData as ListData = new ListData();
        for time in timers{
            timerData.add(time.serialize());
        }
        var dataList as ListData = new ListData(list);
        data.merge({"propertyList": dataList});
        data.merge({"timerData": timerData});
        return data;
    }

    public deserialize(data as MapData) as void{
        /*----------------------------------------------------------------
            Метод загрузки характеристик из MapData
        ------------------------------------------------------------------*/
        if(data.isEmpty) return;
        propertyList = new List<PlayerStatBase>();
        timers = new List<TimerBase>();
        var dataList as ListData = data["propertyList"] as ListData;
        if("timerData" in data){
            var timerData as ListData = data["timerData"] as ListData;
            for timer in timerData{
                var d1 as TimerBase = new TimerBase(player);
                d1.deserialize(timer as MapData);
                timers.add(d1);
            }
        }

        for dataFromList in dataList{
            if("value" in dataFromList){
                if(dataFromList["value"] is DoubleData){
                    propertyList.add(new PlayerStatValue(dataFromList["id"].toString(), dataFromList["value"].asDouble()));
                }
            }
        }
    }

    public generateBaseStats() as void{
        /*----------------------------------------------------------------
            Метод генерации базовых характеристик игрока
        ------------------------------------------------------------------*/
        propertyList = new List<PlayerStatBase>();
        var property = PlayerUtils.getPlayerDificultPrperty(this.player);
        var difficult = PlayerUtils.getPlayerDificult(this.player);

        if(PlayerProperty.MISSKILL in property){
            propertyList.add(new PlayerStatValue("miss_chance", 50.0));
            propertyList.add(new PlayerStatValue("miss_reduce", 0.0));
        }

        propertyList.add(new PlayerStatValue("void_damage", 0.0));
        propertyList.add(new PlayerStatValue("void_damage_buff", 0.0));
        propertyList.add(new PlayerStatValue("divine_damage", 0.0));
        propertyList.add(new PlayerStatValue("divine_damage_buff", 0.0));
        propertyList.add(new PlayerStatValue("chaos_damage", 0.0));
        propertyList.add(new PlayerStatValue("chaos_damage_buff", 0.0));
        propertyList.add(new PlayerStatValue("void_resist", 0.0));
        propertyList.add(new PlayerStatValue("divine_resist", 0.0));
        propertyList.add(new PlayerStatValue("chaos_resist", 0.0));

        propertyList.add(new PlayerStatValue("protect_class", 0.0));
        propertyList.add(new PlayerStatValue("damage_bonus_buff", 0.0));
        propertyList.add(new PlayerStatValue("critical_hit_chance", 0.0));
        propertyList.add(new PlayerStatValue("critical_hit_multiply", 0.0));
        propertyList.add(new PlayerStatValue("critical_hit_rank", 0.0));

        propertyList.add(new PlayerStatValue("water_resist", 0.0));
        propertyList.add(new PlayerStatValue("lava_resist", 0.0));

        propertyList.add(new PlayerStatValue("loot_bonus", 0.0));
        propertyList.add(new PlayerStatValue("loot_rarity_bonus", 0.0));

        propertyList.add(new PlayerStatValue("mind_resist", 0.0));

        switch difficult{
            case EASY:
                propertyList.add(new PlayerStatValue("damage_bonus", 25.0));
                propertyList.add(new PlayerStatValue("damage_reduce_bonus", 25.0));
                break;
            case MEDIUM:
                propertyList.add(new PlayerStatValue("damage_bonus", 0.0));
                propertyList.add(new PlayerStatValue("damage_reduce_bonus", 0.0));
                break;
            case HARD:
                propertyList.add(new PlayerStatValue("damage_bonus", -25.0));
                propertyList.add(new PlayerStatValue("damage_reduce_bonus", -25.0));
                break;
            default:
                break;
        }
    }


    public getStatsMap() as PlayerStatBase[string]{
        var map as PlayerStatBase[string] = {};

        for stat in propertyList{
            map[stat.id] = stat;
        }
        return map;
    }

    public getStatsKey() as List<string>{
        var list as List<string> = new List<string>();
        for stat in propertyList{
            list.add(stat.id);
        }

        return list;
    }



    public updateStats() as void{
        /*----------------------------------------------------------------
            Метод обновления характеристи игрока с учётом инвентаря
                                и бижутерии
        ------------------------------------------------------------------*/
        generateBaseStats();
        updateStatsOnlyInventry(false);
        updateStatsOnlyCurio(false);

    }

    public updateStatsOnlyInventry(clear as bool) as void{
        /*----------------------------------------------------------------
           Метод обновления характеристи игрока с учётом только инвентаря
        ------------------------------------------------------------------*/
        if(clear) generateBaseStats();
        var statList = this.getStatsKey();
        var inventory = player.inventory;

    }

    public updateStatsOnlyCurio(clear as bool) as void{
        /*----------------------------------------------------------------
           Метод обновления характеристи игрока с учётом только бижутерии
        ------------------------------------------------------------------*/
        if(clear) generateBaseStats();
        var statList = this.getStatsKey();
        var curiosInventory = player.getCuriosInventory();
        for i,k in curiosInventory.curios{
            var item as IItemStack = k.stacks.getStackInSlot(0).asIItemStack();

            if(!item.hasTag) continue;
            var itemData as MapData = new MapData(item.tag.asMap());
            if(itemData.isEmpty() || !("sdm_data" in itemData))  continue;
            itemData = itemData["sdm_data"];
            for key in ItemStats.getKeys(){
                if(key in itemData && key in statList){
                    for stat in propertyList{
                        if(stat.id == key){
                            if(stat is PlayerStatValue){
                                (stat as PlayerStatValue).value += itemData[key].asDouble();
                            }
                        }
                    }
                }
            }
        }
    }
}