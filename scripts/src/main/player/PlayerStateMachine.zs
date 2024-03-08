import crafttweaker.api.entity.type.player.Player;
import crafttweaker.api.data.MapData;
import stdlib.List;
import crafttweaker.api.data.IData;
import crafttweaker.api.data.ListData;
import crafttweaker.api.data.DoubleData;
import crafttweaker.api.item.IItemStack;


        /*----------------------------------------------------------------
            Класс атрибутов/характеристик игрока
        ------------------------------------------------------------------*/
public class PlayerStateMachine{
    public var player as Player;
    public var propertyList as List<PlayerStatBase> = new List<PlayerStatBase>();

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


    public syncData() as void{
        /*----------------------------------------------------------------
            Метод синхронизации новых данных игрока
        ------------------------------------------------------------------*/
        if(!("gameSetting" in player.customData)) player.updateCustomData({"gameSetting" : new MapData()});
        val data = player.customData["gameSetting"];
        player.updateCustomData({"gameSetting" : {"playerSateMachine" : new MapData()}});
        player.updateCustomData({"gameSetting" : {"playerSateMachine" : serialize()}});
        println(data["playerSateMachine"] as string);
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
        var dataList as ListData = new ListData(list);
        data.merge({"propertyList": dataList});
        return data;
    }

    public deserialize(data as MapData) as void{
        /*----------------------------------------------------------------
            Метод загрузки характеристик из MapData
        ------------------------------------------------------------------*/
        if(data.isEmpty) return;
        propertyList = new List<PlayerStatBase>();
        var dataList as ListData = data["propertyList"] as ListData;
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