class Pokemon

  attr_accessor :id, :name, :type, :db

  def initialize(id:, name:, type:, db:)
  end

  def self.save(name, type, db)
    if self.id
      self.update
    else
      sql = <<-SQL
        INSERT INTO pokemon (name, type)
        VALUES (?, ?)
      SQL

      @db.execute(sql, name, type)
      @id = @db.execute("SELECT last_insert_rowid() FROM pokemon")[0][0]
    end
  end

  def update
    sql = "UPDATE pokemon SET name = ?, type = ? where id = ?"
    DB[:conn].execute(sql, self.name, self.type, self.id)
  end
end
