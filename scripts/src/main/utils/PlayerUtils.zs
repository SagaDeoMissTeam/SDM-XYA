import crafttweaker.api.entity.type.player.Player;
import crafttweaker.api.data.MapData;
import stdlib.List;


        /*----------------------------------------------------------------
                    Класс с методами для получения разных
                            параметров игрока
        ------------------------------------------------------------------*/
public class PlayerUtils{
    public static getPlayerDificult(player as Player) as PlayerDificult {
        /*----------------------------------------------------------------
                Метод для получения выбраной сложности игрока
        ------------------------------------------------------------------*/
        val data as MapData = player.customData as MapData;

        if("gameSetting" in data){
            val gameSetting = data["gameSetting"] as MapData;

            if("easy_mode" in gameSetting){
                return PlayerDificult.EASY;
            } else if("medium_mode" in gameSetting){
                return PlayerDificult.MEDIUM;
            } else if("hard_mode" in gameSetting){
                return PlayerDificult.HARD;
            }
        }

        return PlayerDificult.NONE;
    }

    public static getPlayerDificultPrperty(player as Player) as List<PlayerProperty>{
        /*----------------------------------------------------------------
                Метод для получения всех усложнений игрока
        ------------------------------------------------------------------*/
        var propertyList as List<PlayerProperty> = new List<PlayerProperty>();
        val data as MapData = player.customData as MapData;
        if("gameSetting" in data){
            val gameSetting = data["gameSetting"] as MapData;

            if("random_start_kit" in gameSetting){
                propertyList.add(PlayerProperty.RANDOM_START_KIT);
            }
            if("randomdimension" in gameSetting){
                propertyList.add(PlayerProperty.RANDOM_DIMENSION);
            }
            if("missskill" in gameSetting){
                propertyList.add(PlayerProperty.MISSKILL);
            }
            if("oredrop" in gameSetting){
                propertyList.add(PlayerProperty.OREDROP);
            }
            if("randomspawndimension" in gameSetting){
                propertyList.add(PlayerProperty.RANDOM_SPAWN_DIMENSION);
            }
        }
        return propertyList;
    }

    public static getPlayerMissReduse(player as Player) as double {
        val data as MapData = player.customData as MapData;
        var stateMachine as PlayerStatBase = PlayerStateMachine.of(player);



        return 0.0;
    }

    public static updatePlayerStats(player as Player, data as string[]) as void{

    }

    public static getPlayerStats(player as Player) as PlayerStatBase[string]{
        /*----------------------------------------------------------------
                Метод для получения статистики игрока |УСТАРЕЛО|
        ------------------------------------------------------------------*/
        var list as PlayerStatBase[string] = {};
        for i in PlayerStateMachine.of(player).propertyList{
            list[i.id] = i;
        }

        return list;
    }
}