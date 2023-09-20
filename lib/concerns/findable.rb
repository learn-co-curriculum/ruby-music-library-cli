require 'pry'
module Concerns
    module Findable
        def find_by_name(name)
            self.all.find { |i| i.name == name }
        end

        def find_or_create_by_name(name)
            self.find_by_name(name) || self.create(name)
        end
    end
    
    module Sortable
        def sort_by(model)
            self.(model).sort { |a, b| a.name <=> b.name }
        end

        def each_with_index(model=all)
            self.sort_by(model).each.with_index(1) { |m, i| puts render(m, i) }
        end

        def render(m,i)
            if m.is_a?(Song)
                "#{i}. #{m.artist.name} - #{m.name} - #{m.genre.name}"
            else
                "#{i}. #{m.name}"
            end
        end
    end
end