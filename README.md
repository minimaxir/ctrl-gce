# Install and Use CTRL on Google Compute Engine

A script + guide on how to set up a machine on Google Compute Engine capable of running and use CTRL to generate conditional text.

## Machine Setup Instructions

This machine is the minimum  configuration powerful enough to run CTRL without going out-of-memory (P100 GPU, 8vCPU, 26 GB RAM). With this configuration, having the VM up will cost **$0.51/hr**.

1. Make sure your Google Compute Engine project has enough quota (8 CPUs and 1 P100; these should be available by default, but request more quota if they aren't)
2. Create an instance, with the following specs:
3. Set Region to `us-west-1` (or any region where you have P100 quota).
4. Set Machine Type to `n1-standard-8`.
5. Set GPU to `Nvidia Tesla P100` and quantity to `1`.
6. Set Boot Disk to `Deep Learning Image: TensorFlow 1.14.0` and Boot Disk Size to `45 GB`.
7. Set `Preemptibility` to `On`.

Once created, SSH into the instance. (recommended way to do is via the gcloud command created from the SSH dropdown)

1. When you log in, it will prompt you to install GPU drivers; say `y`.
2. Download the `install_gce.sh` script from this repo via:

3. Run the downloaded script via:

## Using CTRL

For basic usage, running the command below will load the model and start an interactive prompt.

```sh
python generation.py --model_dir seqlen256_v1.ckpt/
```

## Notes

* Since the model is huge, generation is *very* slow: about 2 tokens per second with the configuration above. (therefore, it takes about 2 minutes for a full generation with default parameters)
* The BPEs CTRL uses are "longer" that those used in GPT-2. As a result, a 256-token generation in CTRL is about the same decoded length as a 1024-token generation in GPT-2.
* When using the `Links` control code, keep in mind that code is conditioned on OpenWebText, which is conditioned on Reddit data. Therefore, there's a bias toward English websites and Reddit-friendly content. [Here's a quick spreadsheet](https://docs.google.com/spreadsheets/d/1O3_1RTnGn_ozcvf6eDLpsmf8ElxIqHg0FKbVfDxGS88/edit?usp=sharing) of the most popular TLDs on Reddit, sans some obvious image-oriented websites.
* It is recommended to use Google Compute Engine (even if you aren't following this guide) as the model itself is hosted in Google Cloud Storage and thus it's relatively fast to transfer to a VM (>100 Mb/s), and also lowers the cost for Salesforce.

## Maintainer/Creator

Max Woolf ([@minimaxir](https://minimaxir.com))

*Max's open-source projects are supported by his [Patreon](https://www.patreon.com/minimaxir). If you found this project helpful, any monetary contributions to the Patreon are appreciated and will be put to good creative use.*

## Special Thanks

[Adam King](https://twitter.com/AdamDanielKing) for identifying a working implementation of loading the model after unexplained setbacks.

## License

MIT

## Disclaimer

This repo has no affiliation or relationship with the CTRL team and/or Salesforce.