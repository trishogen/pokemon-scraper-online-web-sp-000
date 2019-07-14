class Pokemon

  attr_accessor :id, :name, :type, :hp, :db

  def initialize(id:, name:, type:, hp: nil, db:)
    @id = id
    @name = name
    @type = type
    @hp = hp
    @db = db
  end

  def self.save(name, type, db)
    sql = <<-SQL
      INSERT INTO pokemon (name, type)
      VALUES (?, ?)
    SQL

    db.execute(sql, name, type)
    @id = db.execute("SELECT last_insert_rowid() FROM pokemon")[0][0]
  end

  def self.find(id, db)
    sql = "SELECT * FROM pokemon WHERE id = ?"
    row = db.execute(sql, id)[0]
    pokemon = self.new(id: row[0], name: row[1], type: row[2], hp: row[3], db: db)
    pokemon
  end

  def alter_hp(new_hp, db)
    sql= "UPDATE pokemon SET hp = ? WHERE id = ?"
    db.execute(sql, new_hp, self.id)
  end

end
