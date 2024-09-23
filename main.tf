terraform {
  required_providers {
    spotify = {
      version = "~> 0.2.6"
      source  = "conradludgate/spotify"
    }
  }
}

# provide to communicate with spotify apis
provider "spotify" {
  api_key = var.spotify_api_key
}

# datasource to fetch artists songs
data "spotify_search_track" "by_artist" {
  artist = "Anuv Jain"
  limit= 10
}

resource "spotify_playlist" "playlist" {
  # this will be playlist name 
  name        = "Terraform Monsoon Playlist"
  description = "This playlist was created by Vidya using Terraform"
  public      = true
    # total no of songs/track to be added in playlist
  tracks = [
    data.spotify_search_track.by_artist.tracks[0].id,
    data.spotify_search_track.by_artist.tracks[1].id,
    data.spotify_search_track.by_artist.tracks[2].id,
  ]
}
