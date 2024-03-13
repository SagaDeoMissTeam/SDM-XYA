import stdlib.List;
import crafttweaker.api.entity.type.player.Player;
import crafttweaker.api.data.MapData;

public interface ILore{
    public getId(): string;
    public run(player: Player): void;
    public setParent(parent: ILore): void;
    public getParent(): ILore?;
    public serialize(): MapData;
    public deserialize(nbt: MapData): void;

    public getType(): LoreType;
}